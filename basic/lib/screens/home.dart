import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:basic/screens/attendance.dart';
import 'package:basic/screens/calculator.dart';
import 'package:basic/screens/homepage.dart';
import 'package:basic/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:basic/web.dart';
import 'package:basic/screens/timetable.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

GlobalKey<SGPAState> globalKey = GlobalKey();
                
class Home extends StatefulWidget {
  String title;
  Widget widgetForBody;
  var icon ;
    
  Home({Key key, this.title, this.widgetForBody}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  TextStyle heading = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
  TextStyle content = TextStyle(fontSize: 16.0);
  TextStyle style = TextStyle(fontSize: 20.0);

  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project   
     // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon'); 
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        );
  }
  
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
  @override
  Widget build(BuildContext context) {
    
    return 
      WillPopScope(
      onWillPop: _onWillPop,
      child:Scaffold(
      drawerScrimColor: Color.fromRGBO(96, 114, 150, 0.7),
      appBar: AppBar(
        actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(widget.icon),
              onPressed: () {
                  globalKey.currentState.registeredCourses;
              },
            )],
        title: Center(
          child: Text(widget.title),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: widget.widgetForBody,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            _createDrawerItem(
                icon: Icons.keyboard_arrow_up,
                text: 'Login',
                onTap: () => !checklogin()
                    ?setState((){
                      widget.title='QRSMS Login';
                      widget.widgetForBody=Login();
                       widget.icon = null;
                    }):null 
                    ),
            _createDrawerItem(
                icon: Icons.home,
                text: 'Home',
                onTap: () => checklogin() ?
                    
                    setState((){
                      widget.title= 'Home'; widget.widgetForBody= Homepage();
                       widget.icon = null;
                    }):null 
                    ),
            _createDrawerItem(
                icon: Icons.center_focus_strong,
                text: 'Mark Your Attendance',
                onTap: () => 
                    checklogin()?setState((){
                      widget.title= 'Attendance'; widget.widgetForBody= Attendance();
                       widget.icon = null;
                    }):null),
            _createDrawerItem(
                icon: Icons.timeline,
                text: 'Time Table',
                onTap: () {
                  if (checklogin()) {
                   setState(() {
        widget.title='Time Table'; widget.widgetForBody= Timetable();
        widget.icon = null;
    });
                  }
                }),
            _createDrawerItem(
                icon: Icons.keyboard,
                text: 'GPA Calculator',
                onTap: () => setState((){
                      widget.title= 'Gpa Calculator'; widget.widgetForBody= SGPA(key: globalKey,);
                      checklogin()? widget.icon = Icons.code:widget.icon =null;
                    })),
                        
                
                      
            _createDrawerItem(
              icon: Icons.keyboard_arrow_down,
              text: 'Logout',
              onTap: () async {
                if (checklogin()) {
                  if (await logout()) {
                    setState(() {
                      widget.title = 'QRSMS Login';
                      widget.widgetForBody = Login();
                       widget.icon = null;
                    });
                  }
                }
              },
            ),
          ],
        ),
      ),
    ));
  }

  

  Future<bool> logout() async {
    return await WebFunctions.logout();
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader() {
    String name = '';
    checklogin()
        ? name = jsonResponse['first_name'] + ' ' + jsonResponse['last_name']
        : name = '';
    return DrawerHeader(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome' + '\n' + name,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.cyan,
      ),
    );
  }

  
}

bool checklogin() {
    try {
      final cookies = WebFunctions.persistGetter.loadForRequest(Uri.parse(WebFunctions.urlGetter));
      return cookies.isNotEmpty ? true : false;
    } catch (loadForRequest) {
      return false;
    }
  }


Future showNotificationWithDefaultSound(String notification) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'New Post',
    notification.replaceAll('\n', '-'),
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
  }