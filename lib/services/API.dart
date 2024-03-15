import 'dart:convert';

import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceModel.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceState.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceSummary.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/DetailPage/ClassData.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/DetailPage/ClassModel.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Teacher.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/WelcomePage.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/SecureStorage.dart';

class API {
  BuildContext context;
  API(this.context);

  Future<String> getAccessToken() async {
    SecureStorage secureStorage = SecureStorage();
    var accessToken = await secureStorage.readSecureData('accessToken');
    return accessToken;
  }

  Future<String> refreshAccessToken(String refreshToken) async {
    const url =
        'http://localhost:8080/api/token/refreshAccessToken'; // 10.0.2.2
    var headers = {'authorization': refreshToken};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        // print('Create New AccessToken is successfully');
        var newAccessToken = jsonDecode(response.body)['accessToken'];
        return newAccessToken;
      } else if (response.statusCode == 401) {
        print('Refresh Token is expired'); // Navigation to welcomePage
        await SecureStorage().deleteSecureData('refreshToken');
        await SecureStorage().deleteSecureData('accessToken');
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async {
                // Navigate to WelcomePage when dialog is dismissed
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  ),
                );
                return true; // Return true to allow pop
              },
              child: AlertDialog(
                backgroundColor: Colors.white,
                elevation: 0.5,
                title: const Text('Unauthorized'),
                content: const Text(
                    'Your session has expired. Please log in again.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomePage(),
                        ),
                      );
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
        );
        return '';
      } else if (response.statusCode == 498) {
        print('Refresh Token is invalid');
        return '';
      } else {
        print(
            'Failed to refresh accessToken. Status code: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Error234: $e');
      return '';
    }
  }

  Future<List<Class>> getClassForTeacher() async {
    const URL = 'http://localhost:8080/api/teacher/classes'; //10.0.2.2

    var accessToken = await getAccessToken();
    var headers = {'authorization': accessToken};
    try {
      final response = await http.get(Uri.parse(URL), headers: headers);
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        List<Class> data = [];

        if (responseData is List) {
          for (var temp in responseData) {
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
        } else if (responseData is Map<String, dynamic>) {
          try {
            data.add(Class.fromJson(responseData));
          } catch (e) {
            print('Error parsing data: $e');
          }
        } else {
          print('Unexpected data type: $responseData');
        }
        print('Data $data');
        return data;
      } else if (response.statusCode == 498 || response.statusCode == 401) {
        var refreshToken = await SecureStorage().readSecureData('refreshToken');
        var newAccessToken = await refreshAccessToken(refreshToken);
        if (newAccessToken.isNotEmpty) {
          headers['authorization'] = newAccessToken;
          final retryResponse =
              await http.get(Uri.parse(URL), headers: headers);
          if (retryResponse.statusCode == 200) {
            // print('-- RetryResponse.body ${retryResponse.body}');
            // print('-- Retry JsonDecode:${jsonDecode(retryResponse.body)}');
            dynamic responseData = jsonDecode(retryResponse.body);
            List<Class> data = [];

            if (responseData is List) {
              for (var temp in responseData) {
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
            } else if (responseData is Map<String, dynamic>) {
              try {
                data.add(Class.fromJson(responseData));
              } catch (e) {
                print('Error parsing data: $e');
              }
            } else {
              print('Unexpected data type: $responseData');
            }

            // print('Data $data');
            return data;
          } else {
            return [];
          }
        } else {
          print('New Access Token is empty');
          return [];
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<ClassModel?> getStudentsWithAllAttendanceDetails(String classID) async {
    final url = 'http://localhost:8080/api/teacher/classes/detail/$classID';
    var accessToken = await getAccessToken();
    var headers = {'authorization': accessToken};
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        ClassModel data = ClassModel.fromJson(responseData);
        print('Data $data');
        return data;
      } else if (response.statusCode == 498 || response.statusCode == 401) {
        var refreshToken = await SecureStorage().readSecureData('refreshToken');
        var newAccessToken = await refreshAccessToken(refreshToken);
        if (newAccessToken.isNotEmpty) {
          headers['authorization'] = newAccessToken;
          final retryResponse =
              await http.get(Uri.parse(url), headers: headers);
          if (retryResponse.statusCode == 200) {
            // print('-- RetryResponse.body ${retryResponse.body}');
            // print('-- Retry JsonDecode:${jsonDecode(retryResponse.body)}');
            dynamic responseData = jsonDecode(retryResponse.body);
            ClassModel data = ClassModel.fromJson(responseData);

            // print('Data $data');
            return data;
          } else {
            return null;
          }
        } else {
          print('New Access Token is empty');
          return null;
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Future<List<Class>> getClassForTeacher(String teacherID) async {
  //   final url = 'http://localhost:8080/api/teacher/getClasses';
  //   var request = {'teacherID': teacherID};
  //   var body = json.encode(request);
  //   var headers = {
  //     'Content-type': 'application/json; charset=UTF-8',
  //     'Accept': 'application/json',
  //   };
  //   final response =
  //       await http.post(Uri.parse(url), headers: headers, body: body);
  //   try {
  //     if (response.statusCode == 200) {
  //       print('Respone.body ${response.body}');
  //       print('JsonDecode:${jsonDecode(response.body)}');
  //       List classTeacherList = jsonDecode(response.body);
  //       List<Class> data = [];
  //       for (var temp in classTeacherList) {
  //         if (temp is Map<String, dynamic>) {
  //           try {
  //             data.add(Class.fromJson(temp));
  //           } catch (e) {
  //             print('Error parsing data: $e');
  //           }
  //         } else {
  //           print('Invalid data type: $temp');
  //         }
  //       }
  //       print('Data ${data}');
  //       return data;
  //     } else {
  //       print('Failed to load data. Status code: ${response.statusCode}');
  //       return [];
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return [];
  //   }
  // }

  Future<AttendanceForm?> createFormAttendance(
      String classID,
      String startTime,
      String endTime,
      int typeAttendance,
      String location,
      double latitude,
      double longtitude,
      double radius) async {
    const url = 'http://localhost:8080/api/teacher/form/submit';
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

  Future<AttendanceDetailResponseStudent>
      getStudentClassAttendanceDetail() async {
    const url = 'http://localhost:8080/test/api/getStudentFakeAPI';
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print('Successfully fetched data');
        // print('JsonDecode: ${jsonDecode(response.body)}');
        return AttendanceDetailResponseStudent.fromJson(
            jsonDecode(response.body));
      } else {
        print('Failed to load data: ${response.statusCode}');
        return AttendanceDetailResponseStudent(
            data: [],
            stats: AttendanceStatus(all: 0, pass: 0, ban: 0, warning: 0));
      }
    } catch (error) {
      print('Error: $error');
      return AttendanceDetailResponseStudent(
          data: [],
          stats: AttendanceStatus(all: 0, pass: 0, ban: 0, warning: 0));
    }
  }

  Future<AttendanceSummary> getAttendanceSummary() async {
    const url =
        'http://localhost:8080/test/api/fakeAttendanceDetailsRecordWith7PresenceAnd2Late';
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print('Successfully----');
        return AttendanceSummary.fromJson(jsonDecode(response.body));
      } else {
        print('Failed------');
        return AttendanceSummary(
            data: [], all: 0, present: 0, absent: 0, late: 0);
      }
    } catch (e) {
      print('Error: $e');
      return AttendanceSummary(
          data: [], all: 0, present: 0, absent: 0, late: 0);
    }
  }
}
