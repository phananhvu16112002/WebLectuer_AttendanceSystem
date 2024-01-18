import 'dart:convert';

import 'package:weblectuer_attendancesystem_nodejs/models/AttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Class.dart';
import 'package:http/http.dart' as http;

class API {
  Future<List<Class>> getClassForTeacher(String teacherID) async {
    final url = 'http://localhost:8080/api/teacher/getClasses';
    var request = {'teacherID': teacherID};
    var body = json.encode(request);
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    try {
      if (response.statusCode == 200) {
        print('Respone.body ${response.body}');
        print('JsonDecode:${jsonDecode(response.body)}');
        List classTeacherList = jsonDecode(response.body);
        List<Class> data = [];
        for (var temp in classTeacherList) {
          if (temp is Map<String, dynamic>) {
            try {
              data.add(Class.fromJson(temp));
            } catch (e) {
              print('Error parsing data: $e');
            }
          } else {
            print('Invalid data type: $temp');
          }
        }
        print('Data ${data}');
        return data;
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<AttendanceForm?> createFormAttendance(
      String classID,
      String startTime,
      String endTime,
      int typeAttendance,
      String location,
      double latitude,
      double longtitude,
      double radius) async {
    const url = 'http://localhost:8080/api/teacher/createAttendanceForm';
    var request = {
      'classID': classID,
      'startTime': startTime,
      'endTime': endTime,
      'type': typeAttendance,
      'location': location,
      'latitude': latitude,
      'longtitude': longtitude,
      'radius': radius
    };
    var body = json.encode(request);
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    try {
      if (response.statusCode == 200) {
        print('Respone.body ${response.body}');
        print('JsonDecode:${jsonDecode(response.body)}');
        Map<String, dynamic> data = jsonDecode(response.body);
        try {
          AttendanceForm attendanceForm = AttendanceForm.fromJson(data);
          return attendanceForm;
        } catch (e) {
          print('Error parsing data: $e');
        }
      } else {
        print('Error:${jsonDecode(response.body)['message']}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }
}
