import 'dart:io';
import 'package:basic/screens/login.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class WebFunctions {
  static final storage = new FlutterSecureStorage();

  static PersistCookieJar persistentCookies;
  static final String url = "http://qrsms-v1.herokuapp.com";
  static final Dio _dio = Dio();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<Directory> get _localCoookieDirectory async {
    final path = await _localPath;
    print(path);
    final Directory dir = new Directory('$path/cookies');
    await dir.create();
    return dir;
  }

  Future<String> _getCsrftoken() async {
    try {
      String csrfTokenValue ;
      final Directory dir = await _localCoookieDirectory;
      final cookiePath = dir.path;
      persistentCookies = new PersistCookieJar(dir: '$cookiePath');
      persistentCookies
          .deleteAll(); //clearing any existing cookies for a fresh start
      _dio.interceptors.add(CookieManager(
              persistentCookies) //this sets up _dio to persist cookies throughout subsequent requests
          );

      _dio.options = new BaseOptions(
        baseUrl: url,
        contentType: ContentType.json.toString(),
        responseType: ResponseType.plain,
        connectTimeout: 5000,
        receiveTimeout: 100000,
        headers: {
          HttpHeaders.userAgentHeader: "dio",
          "Connection": "keep-alive",
        },
      ); //BaseOptions will be persisted throughout subsequent requests made with _dio
      _dio.interceptors
          .add(InterceptorsWrapper(onResponse: (Response response) {
        List<Cookie> cookies = persistentCookies.loadForRequest(Uri.parse(url));

        csrfTokenValue = cookies
            .firstWhere((c) => c.name == 'csrftoken', orElse: () => null)
            ?.value;
        
        if (csrfTokenValue != null) {
          _dio.options.headers['X-CSRF-TOKEN'] =
              csrfTokenValue; //setting the csrftoken from the response in the headers
           
            
        }
        return response;
      },
      ));
      
      await _dio.get("/management/get_csrf");
      return csrfTokenValue;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<String> getSessionId(String username, String password) async {
    try {
      final csrf = await _getCsrftoken();
      print("IN Session: " + csrf);
      FormData formData = new FormData.fromMap({
        "username": username,
        "password": password,
        "csrfmiddlewaretoken": '$csrf'
      });
      Response response = await _dio.post("/student/login/", data: formData);

      if (response.statusCode == 200) {
        Response response1 = await _dio.get("/student/home_json/");
        return response.data + '/' + response1.data;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response.statusCode == 403)
          return e.response.data + '/' + e.response.data;
      } else {
        print(e.request);
        print(e.message);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
    return null;
  }

  static String get urlGetter {
    return url;
  }

  static Dio get dioGetter {
    return _dio;
  }

  static PersistCookieJar get persistGetter {
    return persistentCookies;
  }

  static Future<String> getTimetable() async {
    Response response = await _dio.get("/student/timetable/");
    if (response.statusCode == 200)
      return response.data;
    else
      return 'Something went wrong';
  }

  static Future<String>  getRegisteredCourses() async {
    print(await WebFunctions.storage.read(key: 'csrftoken'));

    Response response = await _dio.get("/student/registration/available_courses/");
    if (response.statusCode == 200)
      return response.data;
    else
      return 'Something went wrong';
  }

  static Future<String> postAttendance(String qrcode) async {
    final cookie = persistentCookies.loadForRequest(Uri.parse(url))[0];
    final csrf = cookie.toString().split('=')[1].split(';')[0];
    try {
      print("IN Session: " + csrf);
      FormData formData = new FormData.fromMap({
        "qr_code": qrcode,
        "csrfmiddlewaretoken": '$csrf',
      });
      Response response = await _dio.post("/student/postQR/", data: formData);
      return response.data;
    } on DioError catch (e) {
      print(e.response.statusCode);
      if (e.response.statusCode == 400) return '{"message":"Not Registered"}';
    } catch (error) {
      return '{"message":"Network Problem"}';
    }
    return '{"message":"Network Problem"}';
  }

  static Future<bool> logout() async {
    
    try {
      final cookie = persistentCookies.loadForRequest(Uri.parse(url))[0];
      final csrf = cookie.toString().split('=')[1].split(';')[0];
      print("IN Session: " + csrf);
      FormData formData =
          new FormData.fromMap({"csrfmiddlewaretoken": '$csrf'});
      Response response = await _dio.post("/student/logout/", data: formData);

      if (response.statusCode == 200) {
        jsonTimetable = null;
        jsonResponseStd = '';
        jsonResponse = '';
        _dio.interceptors.clear();
        _dio.options.headers['X-CSRF-TOKEN'] = '';
        persistentCookies.deleteAll();
        print(persistentCookies.loadForRequest(Uri.parse(url)));

        return true;
      }
    } on DioError catch (e) {
      print(e);
      return false;
    }
    return false;
   }
}
