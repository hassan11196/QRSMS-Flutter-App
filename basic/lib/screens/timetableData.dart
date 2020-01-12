import 'package:basic/screens/login.dart';

class TabelData {
  var ans = new List.generate(5, (_) => List.filled(8, 'Free'.toUpperCase()));

  List<String> slot = [
    '08-8:55',
    '09-09:55',
    '10-10:55',
    '11-11:55',
    '12-12:55',
    '1-1:55',
    '2-2:55',
    '3-3:55'
  ];
  List<String> slotLab = [
    '08-10:55',
    '09-11:55',
    '10-12:55',
    '11-1:55',
    '12-2:55',
    '1-3:55',
  ];
  TabelData() {
    if(jsonTimetable != null && jsonTimetable['success']==1){
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < jsonTimetable[i.toString()].length; j++) {
        if (slot.indexOf(jsonTimetable[i.toString()][j]['timing']) >= 0)
          ans[i][slot.indexOf(jsonTimetable[i.toString()][j]['timing'])] =
              jsonTimetable[i.toString()][j]['subject']
                      .toString()
                      .replaceAll('-', '\n') +
                  '\n' +
                  jsonTimetable[i.toString()][j]['room'];
        else if (slotLab.indexOf(jsonTimetable[i.toString()][j]['timing']) >=
            0) {
          ans[i][slotLab.indexOf(jsonTimetable[i.toString()][j]['timing'])] =
              jsonTimetable[i.toString()][j]['subject']
                      .toString()
                      .replaceAll('-', '\n') +
                  '\n' +
                  jsonTimetable[i.toString()][j]['room'];
          ans[i][slotLab.indexOf(jsonTimetable[i.toString()][j]['timing']) +
              1] = jsonTimetable[i.toString()][j]['subject']
                  .toString()
                  .replaceAll('-', '\n') +
              '\n' +
              jsonTimetable[i.toString()][j]['room'];
          ans[i][slotLab.indexOf(jsonTimetable[i.toString()][j]['timing']) +
              2] = jsonTimetable[i.toString()][j]['subject']
                  .toString()
                  .replaceAll('-', '\n') +
              '\n' +
              jsonTimetable[i.toString()][j]['room'];
        }
      }
    }
    }
  }

}
