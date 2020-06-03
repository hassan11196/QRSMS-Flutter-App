import 'login.dart';

class Data {
  String first_name;
  String last_name;
  String email;
  String username;
  String gender;
  String cnic;
  String current_address;
  int current_home_phone;
  int current_postal_code;
  String current_city;
  String current_country;
  String permanent_address;
  int permanent_home_phone;
  int permanent_postal_code;
  String permanent_city;
  String permanent_country;
  String dob;
  String nationality;
  int mobile_contact;
  int emergency_contact;
  String campus;
  int batch;
  int arn;
  String degree;
  int curent_sems;

  Data() {
    this.first_name = jsonResponse["first_name"];
    this.last_name = jsonResponse["last_name"];
    this.email = jsonResponseStd['data'][0]['uni_mail'];
    this.username = jsonResponse["username"];
    this.gender = jsonResponse["gender"];
    this.cnic = jsonResponse["CNIC"];
    this.current_address = jsonResponse["current_address"];
    this.current_home_phone = jsonResponse["current_home_phone"];
    this.current_postal_code = jsonResponse["current_postal_code"];
    this.current_city = jsonResponse["current_city"];
    this.current_country = jsonResponse["current_country"];
    this.permanent_address = jsonResponse["permanent_address"];
    this.permanent_home_phone = jsonResponse["permanent_home_phone"];
    this.permanent_postal_code = jsonResponse["permanent_postal_code"];
    this.permanent_city = jsonResponse["permanent_city"];
    this.permanent_country = jsonResponse["permanent_country"];
    this.dob = jsonResponse["DOB"];
    this.nationality = jsonResponse["nationality"];
    this.mobile_contact = jsonResponse["mobile_contact"];
    this.emergency_contact = jsonResponse["emergency_contact"];
    this.campus = jsonResponseStd['data'][0]["semester_code"];
    this.batch = jsonResponseStd['data'][0]["batch"];
    this.arn = jsonResponseStd['data'][0]["arn"];
    this.degree = jsonResponseStd['data'][0]['degree_name_enrolled'];
    this.curent_sems = jsonResponseStd['data'][0]['current_semester'];
  }
}
