import 'package:basic/screens/timetableData.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:basic/screens/login.dart';
import 'package:basic/screens/home.dart';

class Timetable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Timetable();
  }
}
class _Timetable extends State<Timetable> {
  TabelData data = TabelData();
  double space = 2.0;
  var textStyle = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800);
  var textStyle1 = TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600);
  

  
  
  
  @override
  Widget build(BuildContext context) {

    if(jsonTimetable['success']==1){
    var index =-1;
    double width = MediaQuery.of(context).size.width / 7;
    double height =
        (MediaQuery.of(context).size.height - 55.0 - (space * 11)) / 9;
    DateTime date = DateTime.now();
    var time = [8,9,10,11,12,13,14,15];
    int currentDay=0 ,currentTime=0,currentSlot=null;
    
    if(date.weekday<=5){
      currentDay = date.weekday;
      print(currentDay);
      int index =time.indexOf(int.parse(date.toString().split(' ')[1].split(':')[0]));
      print(time);
      if(index>-1){
        currentTime=index;
        currentSlot = (currentTime*6) + currentDay;
      }
      print(currentSlot);
      
    }
    return Column(children: <Widget>[
      Container(
        height: 50.0,
        child: ResponsiveGridList(
            desiredItemWidth: width,
            minSpacing: space,
            children: [
              '',
              'MON',
              'TUE',
              'WED',
              'THURS',
              'FRI',
            ].map((i) {
              Color c;
              if (i.toString() != '') c = Colors.white;
              
              return Container(
                height: 50.0,
                alignment: Alignment(0, 0),
                color: c,
                child: Text(
                  i.toString().toUpperCase(),
                  style: textStyle,
                ),
              );
            }).toList()),
      ),
      Flexible(
        child: ResponsiveGridList(
            desiredItemWidth: width,
            minSpacing: space,
            children:
                [
              '08:00 - 08:55',
              data.ans[0][0],
              data.ans[1][0],
              data.ans[2][0],
              data.ans[3][0],
              data.ans[4][0],
              '09:00 - 09:55',
              data.ans[0][1],
              data.ans[1][1],
              data.ans[2][1],
              data.ans[3][1],
              data.ans[4][1],
              '10:00 - 10:55',
              data.ans[0][2],
              data.ans[1][2],
              data.ans[2][2],
              data.ans[3][2],
              data.ans[4][2],
              '11:00 - 11:55',
              data.ans[0][3],
              data.ans[1][3],
              data.ans[2][3],
              data.ans[3][3],
              data.ans[4][3],
              '12:00 - 12:55',
              data.ans[0][4],
              data.ans[1][4],
              data.ans[2][4],
              data.ans[3][4],
              data.ans[4][4],
              '01:00 - 01:55',
              data.ans[0][5],
              data.ans[1][5],
              data.ans[2][5],
              data.ans[3][5],
              data.ans[4][5],
              '02:00 - 02:55',
              data.ans[0][6],
              data.ans[1][6],
              data.ans[2][6],
              data.ans[3][6],
              data.ans[4][6],
              '03:00 - 03:55',
              data.ans[0][7],
              data.ans[1][7],
              data.ans[2][7],
              data.ans[3][7],
              data.ans[4][7],
            ].map((i) {
              index=index+1;
                
              Color c;
              var style,alignment;
              if (i.toString().contains(':')) {
                c = Colors.white;
                style = textStyle;
                alignment = Alignment(0,0);
                
                
              } else if (i == 'free'.toUpperCase()) {
                c = Colors.grey;
                style = textStyle1;
                alignment = Alignment(0,0);
              } else {
                c = Colors.cyan;
                style = textStyle1;
                alignment = null;
                if(index==currentSlot){
                 c = Colors.cyanAccent;
                 showNotificationWithDefaultSound(i);
                }     
                
              }
                       
              return Container(
                height: height,
                padding: EdgeInsets.all(4.0),
                alignment: alignment,
                color: c,
                child: Text(
                  i.toString(),
                  style: style,
                ),
              );
              
            }).toList()),
      ),
      SizedBox(
        height: 5.0,
      )
    ]);}
    else{
      return Center(child: Text('Not Registered',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),);
    }
  }
}
