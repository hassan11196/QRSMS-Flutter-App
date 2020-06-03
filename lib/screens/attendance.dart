import 'dart:async';
import 'dart:convert';

import 'package:basic/web.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'package:sweetalert/sweetalert.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String qrcode = '';

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 200.0,
          height: 50.0,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              color: Colors.cyan,
              onPressed: _scan,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Icon(Icons.center_focus_strong),
                  SizedBox(width: 20.0),
                  Text(
                    "Scan",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ],
              ))),
    );
  }

  void _showDialog(String message, String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return 
        
        
        AlertDialog(
        
          title: Text(status,style: TextStyle(fontSize:20.0,fontWeight: FontWeight.bold),),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future _scan() async {
    String qrcode = await scanner.scan();
    setState(() => this.qrcode = qrcode);
    print(this.qrcode);
    String response = await WebFunctions.postAttendance(this.qrcode);
    var json = jsonDecode(response);
    String message = json['message'];
    String status = 'Attendance';

    if(json['message'] == 'Attendance Marked' || json['message'] == 'Attendance Already Marked'){
    SweetAlert.show(context,
                      title: status,
                      subtitle: message,
                      style: SweetAlertStyle.success);
    }else{
      SweetAlert.show(context,
                      title: status,
                      subtitle: message,
                      style: SweetAlertStyle.error);
    }

    
    // _showDialog(message, status);
  }
}
