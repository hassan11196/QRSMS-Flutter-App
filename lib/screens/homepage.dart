import 'package:flutter/cupertino.dart';
import 'package:basic/screens/gpachart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:basic/screens/data.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  TextStyle heading = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
  TextStyle content = TextStyle(fontSize: 16.0);
  String title;

  TextStyle style = TextStyle(fontSize: 20.0);
  Data object = Data();

  @override
  Widget build(BuildContext context) {
    var color = Colors.cyan;
    var headingColor = Colors.white;
    var border = Border.all(color: Colors.grey);
    return Center(
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: border,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: color,
                        child: Container(
                            margin: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  color: headingColor,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  'University Information',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: headingColor),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text('ARN : ', style: heading),
                          Text(
                            object.arn.toString(),
                            style: content,
                          )
                        ]),
                        SizedBox(height: 5.0),
                        // Row(children: <Widget>[
                        //   Text('Campus : ', style: heading),
                        //   Expanded(
                        //     child: Text(
                        //       object.campus,
                        //       style: content,
                        //     ),
                        //   )
                        // ]),
                        SizedBox(height: 5.0),
                        Row(children: <Widget>[
                          Text('Batch : ', style: heading),
                          Text(
                            object.batch.toString(),
                            style: content,
                          )
                        ]),
                        SizedBox(height: 5.0),
                        Row(children: <Widget>[
                          Text('Roll # : ', style: heading),
                          Text(
                            object.username,
                            style: content,
                          )
                        ]),
                        SizedBox(height: 5.0),
                        Row(children: <Widget>[
                          Text('Degree : ', style: heading),
                          Text(
                            object.degree,
                            style: content,
                          )
                        ]),
                        SizedBox(height: 5.0),
                        Row(children: <Widget>[
                          Text('Current Semester : ', style: heading),
                          Text(
                            object.curent_sems.toString(),
                            style: content,
                          )
                        ]),
                      ],
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: border,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: color,
                        child: Container(
                            margin: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.date_range, color: headingColor),
                                SizedBox(width: 5.0),
                                Text(
                                  'Personal Information',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: headingColor),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text('Name : ', style: heading),
                          Text(
                            object.first_name + ' ' + object.last_name,
                            style: content,
                          )
                        ]),
                        SizedBox(height: 5.0),
                        Row(children: <Widget>[
                          Text('CNIC : ', style: heading),
                          Text(
                            object.cnic,
                            style: content,
                          )
                        ]),
                        SizedBox(height: 5.0),
                        Row(children: <Widget>[
                          Text('DOB : ', style: heading),
                          Text(
                            object.dob,
                            style: content,
                          )
                        ]),
                        SizedBox(height: 5.0),
                        Row(children: <Widget>[
                          Text('Gender : ', style: heading),
                          Text(
                            object.gender,
                            style: content,
                          )
                        ]),
                        SizedBox(height: 5.0),
                        Row(children: <Widget>[
                          Text('Mobile # : ', style: heading),
                          Text(
                            object.mobile_contact.toString(),
                            style: content,
                          )
                        ]),
                        SizedBox(height: 5.0),
                        Row(children: <Widget>[
                          Text('Nationality : ', style: heading),
                          Text(
                            object.nationality,
                            style: content,
                          )
                        ]),
                        SizedBox(height: 5.0),
                        Row(children: <Widget>[
                          Text('Email : ', style: heading),
                          Text(
                            object.email,
                            style: content,
                          )
                        ]),
                      ],
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: border,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: color,
                        child: Container(
                            margin: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.contacts,
                                  color: headingColor,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  'Contact Information',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: headingColor),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Text('Permanent : ', style: heading)
                          ]),
                          SizedBox(height: 10.0),
                          Row(children: <Widget>[
                            Text('Address : ', style: heading),
                            Text(
                              object.permanent_address,
                              style: content,
                            )
                          ]),
                          SizedBox(height: 5.0),
                          Row(children: <Widget>[
                            Text('Home # : ', style: heading),
                            Text(
                              object.permanent_home_phone.toString(),
                              style: content,
                            )
                          ]),
                          SizedBox(height: 5.0),
                          Row(children: <Widget>[
                            Text('Postal Code : ', style: heading),
                            Text(
                              object.permanent_postal_code.toString(),
                              style: content,
                            )
                          ]),
                          SizedBox(height: 5.0),
                          Row(children: <Widget>[
                            Text('City : ', style: heading),
                            Text(
                              object.permanent_city,
                              style: content,
                            )
                          ]),
                          SizedBox(height: 5.0),
                          Row(children: <Widget>[
                            Text('Country : ', style: heading),
                            Text(
                              object.permanent_country,
                              style: content,
                            )
                          ]),
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Text('Current : ', style: heading)
                          ]),
                          SizedBox(height: 10.0),
                          Row(children: <Widget>[
                            Text('Address : ', style: heading),
                            Text(
                              object.current_address,
                              style: content,
                            )
                          ]),
                          SizedBox(height: 5.0),
                          Row(children: <Widget>[
                            Text('Home # : ', style: heading),
                            Text(
                              object.current_home_phone.toString(),
                              style: content,
                            )
                          ]),
                          SizedBox(height: 5.0),
                          Row(children: <Widget>[
                            Text('Postal Code : ', style: heading),
                            Text(
                              object.current_postal_code.toString(),
                              style: content,
                            )
                          ]),
                          SizedBox(height: 5.0),
                          Row(children: <Widget>[
                            Text('City : ', style: heading),
                            Text(
                              object.current_city,
                              style: content,
                            )
                          ]),
                          SizedBox(height: 5.0),
                          Row(children: <Widget>[
                            Text('Country : ', style: heading),
                            Text(
                              object.current_country,
                              style: content,
                            )
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: border,
                borderRadius: BorderRadius.circular(5.0),
              ),
              height: 400.0,
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: color,
                        child: Container(
                            margin: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.assessment, color: headingColor),
                                SizedBox(width: 5.0),
                                Text(
                                  'Semester GPA',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: headingColor),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: SimpleBarChart(
                      _createSampleData(),
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}

List<charts.Series<Gpa, String>> _createSampleData() {
  final data = [
    new Gpa('F-17', 4),
    new Gpa('S-18', 3),
    new Gpa('F-18', 2),
    new Gpa('S-19', 1),
    new Gpa('F-19', 4),
    new Gpa('S-20', 3),
    new Gpa('F-20', 2),
    new Gpa('S-21', 1),
  ];

  return [
    new charts.Series<Gpa, String>(
      id: 'GPA',
      colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
      domainFn: (Gpa sales, _) => sales.year,
      measureFn: (Gpa sales, _) => sales.gpa,
      data: data,
    )
  ];
}

/// Sample ordinal data type.
class Gpa {
  final String year;
  final int gpa;

  Gpa(this.year, this.gpa);
}
