
import 'package:basic/screens/login.dart';
import 'package:basic/screens/home.dart';

import 'package:flutter/material.dart';



void main() {
  
  
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
