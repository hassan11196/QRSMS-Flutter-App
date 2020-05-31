import 'package:basic/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:basic/web.dart';

import 'dart:convert';

import 'package:basic/screens/home.dart';

bool isPressed = false;

var jsonResponse;
var jsonResponseStd;
var jsonTimetable = null;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String id = "";
  String password = "";
  String error = "";
  TextStyle style = TextStyle(fontSize: 15.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        obscureText: false,
        style: style,
        validator: validateEmail,
        keyboardType: TextInputType.text,
        enableInteractiveSelection: false,
        enabled: !isPressed ? true : false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "NU ID",
          labelText: "NU ID",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onSaved: (String value) {
          id = value;
        });
    final passwordField = TextFormField(
        enableInteractiveSelection: false,
        obscureText: true,
        style: style,
        enabled: !isPressed ? true : false,
        validator: validatePassword,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            labelText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        onSaved: (String value) {
          password = value;
        });
    final loading = CircularProgressIndicator(
      valueColor:
          new AlwaysStoppedAnimation<Color>(Color.fromRGBO(96, 114, 150, 1)),
      backgroundColor: Colors.white,
    );
    final loginButon = Material(
      elevation: !isPressed ? 5.0 : 0.0,
      borderRadius: BorderRadius.circular(5.0),
      color: !isPressed ? Colors.cyan : Colors.white,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
        onPressed: !isPressed
            ? () {
                //if field is valid then save those field input
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  print("Finally $id and $password");
                  setState(() {
                    if (!isPressed) {
                      isPressed = true;
                    }
                  });
                  makeRequest(id, password, context);
                }
              }
            : null,
        child: !isPressed
            ? Text("Login",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold))
            : loading,
      ),
    );
    final werror = Text(
      error,
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
      ),
    );
    return SingleChildScrollView(
      child: Center(
        child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(46.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 255.0,
                      child: Image.asset(
                        "images/qrsmslogo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    werror,
                    SizedBox(height: 40.0),
                    emailField,
                    SizedBox(height: 20.0),
                    passwordField,
                    SizedBox(height: 30.0),
                    loginButon,
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<void> makeRequest(
      String id, String password, BuildContext context) async {
    WebFunctions w1 = WebFunctions();
    String response = await w1.getSessionId(id, password);
    if (response != null) {
      jsonResponse = jsonDecode(response.split('/')[0]);
      jsonResponseStd = jsonDecode(response.split('/')[1]);
      if (jsonResponse["status"] == "Invalid Username of Password.") {
        setState(() {
          isPressed = false;
          error = jsonResponse["status"];
        });
      } else {
        makeRequestT();
        setState(() {
          isPressed = false;
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Home(title: 'Home', widgetForBody: Homepage())),
          );
        });
      }
    } else {
      setState(() {
        isPressed = false;
        error = 'Check your internet connectivity';
      });
    }
  }
}

String validateEmail(String value) {
  Pattern pattern = r'^([0-9]{2})(K)(-)([0-9]{4})$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return "Enter valid ID (17K-3654)";
  else
    return null;
}

String validatePassword(String value) {
  if (value.length <= 0) {
    return "Please enter password!";
  } else
    return null;
}

Future<void> makeRequestT() async {
  String response = await WebFunctions.getTimetable();
  jsonTimetable = jsonDecode(response);
}
