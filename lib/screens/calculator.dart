import 'package:flutter/material.dart';
import 'package:basic/web.dart';
import 'dart:convert';

class SGPA extends StatefulWidget {
  SGPA({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SGPAState();
  }
}

class SGPAState extends State<SGPA> {
  var crdt = [0, 1, 2, 3];
  var gpa = [4.00, 3.67, 3.33, 3.00, 2.67, 2.33, 2.00, 1.67, 1.33, 1.00, 0.00];

  List<String> subj = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
  ];
  var _addSubj = <TextEditingController>[];
  var _addCrd = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  var _addGpa = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
  ];
  TextEditingController cgpa = TextEditingController();
  TextEditingController crdthr = TextEditingController();
  var sum = 0;
  var grdPoint = 0.0;
  var _finalGpa = 0.0;
  var _finalCgpa = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Subject'.toUpperCase(),
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 115),
            Expanded(
              child: Text(
                'Crdt Hr',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                'Gpa'.toUpperCase(),
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Flexible(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: subj.length,
            itemBuilder: (BuildContext context, int index) {
              _addSubj.add(TextEditingController());
              return Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _addSubj[index],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 8.0),
                        hintText: 'Subject',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 70.0,
                    child: DropdownButton<int>(
                      elevation: 2,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      isDense: true,
                      iconSize: 40.0,
                      items: crdt.map((int element) {
                        return DropdownMenuItem<int>(
                          value: element,
                          child: Text(element.toString()),
                        );
                      }).toList(),
                      onChanged: (int newValue) {
                        setState(() {
                          _addCrd[index] = newValue;
                        });
                      },
                      value: _addCrd[index],
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 80.0,
                    child: DropdownButton<double>(
                      elevation: 2,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      isDense: true,
                      iconSize: 40.0,
                      items: gpa.map((double element) {
                        return DropdownMenuItem<double>(
                          value: element,
                          child: Text(
                            element.toString(),
                          ),
                        );
                      }).toList(),
                      onChanged: (double newValue) {
                        setState(() {
                          this._addGpa[index] = newValue;
                        });
                      },
                      value: this._addGpa[index],
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(height: 80.0),
            Expanded(
              child: TextField(
                controller: cgpa,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                    hintText: 'CGPA',
                    labelText: 'CGPA',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: TextField(
                controller: crdthr,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                    hintText: 'Crdt Hr.',
                    labelText: 'Crdt Hr',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text('Calculate'),
                onPressed: () {
                  for (int i = 0; i < _addCrd.length; i++) {
                    sum = sum + _addCrd[i];
                    grdPoint = grdPoint + _addCrd[i] * _addGpa[i];
                  }
                  setState(() {
                    _finalGpa = grdPoint / sum;
                  });
                  if (cgpa.text.isNotEmpty && crdthr.text.isNotEmpty) {
                    sum = sum + int.parse(crdthr.text);
                    grdPoint = grdPoint +
                        int.parse(crdthr.text) * double.parse(cgpa.text);
                  }
                  setState(() {
                    _finalCgpa = grdPoint / sum;
                    sum = 0;
                    grdPoint = 0.0;
                  });
                },
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            RaisedButton(
              child: Text('Reset'),
              onPressed: () {
                setState(() {
                  for (int i = 0; i < _addCrd.length; i++) _addCrd[i] = 0;
                  for (int i = 0; i < _addSubj.length; i++)
                    _addSubj[i].text = '';
                  for (int i = 0; i < _addGpa.length; i++) _addGpa[i] = 0.0;
                  cgpa.text = '';
                  crdthr.text = '';
                  sum = 0;
                  grdPoint = 0.0;
                  _finalGpa = 0.0;
                  _finalCgpa = 0.0;
                });
              },
            ),
            SizedBox(
              width: 10.0,
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                setState(() {
                  subj.add((subj.length + 1).toString());
                  _addCrd.add(0);
                  _addGpa.add(0.0);
                });
              },
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'SGPA : ' + _finalGpa.toStringAsFixed(2),
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                'CGPA : ' + _finalCgpa.toStringAsFixed(2),
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ]),
    );
  }

  void get registeredCourses async {
    int k = 0;
    var registeredCourse =
        jsonDecode(await WebFunctions.getRegisteredCourses());

    for (int i = 0;
        i < registeredCourse['regular_courses'][0]['courses_offered'].length;
        i++) {
      if (registeredCourse['regular_courses'][0]['courses_offered'][i]
              ['status'] ==
          'R') {
        if (k > _addSubj.length - 1) {
          setState(() {
            subj.add((subj.length + 1).toString());
            _addSubj.add(TextEditingController());
            _addCrd.add(0);
            _addGpa.add(0.0);
          });
        }
        setState(() {
          this._addCrd[k] = registeredCourse['regular_courses'][0]
              ['courses_offered'][i]['course']['credit_hour'];
          _addSubj[k].text = registeredCourse['regular_courses'][0]
              ['courses_offered'][i]['course']['course_name'];
        });
        k++;
      }
    }
  }
}
