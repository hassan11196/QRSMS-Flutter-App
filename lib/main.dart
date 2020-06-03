


import 'package:basic/screens/login.dart';
import 'package:basic/screens/home.dart';
import 'package:basic/web.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'package:flutter/material.dart';

// void checkNotfication()
// {
//   DateTime date = DateTime.now();
//   var time = [8,9,10,11,12,13,14,15];
//   int currentDay=0 ,currentTime=0;
  
//   if(date.weekday<=5){
//     currentDay = date.weekday-1;
//     print(currentDay);
//     int index =time.indexOf(int.parse(date.toString().split(' ')[1].split(':')[0]));
//     print(time);
//     if(index>-1){
//       currentTime=index;
//       TabelData data = new TabelData();
//       if(data.ans[currentDay][currentTime]!='Free'.toUpperCase()){
//         showNotificationWithDefaultSound(data.ans[currentDay][currentTime]);
//       }
      
//     }
    
//   }
// }

void main() {
  // if(checklogin())
  // var timer = Timer.periodic(Duration(minutes: 10), (Timer t) => checkNotfication());
  runApp(MaterialApp(
    title: "QRSMS APP",
    home: !checklogin()? Home(
      title: 'QRSMS Login',
      widgetForBody: Login(),
    ):Home(
      title: 'Home',
      widgetForBody: Home(),
    ),
    debugShowCheckedModeBanner: false,
  ));
}
