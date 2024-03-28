import 'dart:convert';
import 'dart:io';

import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceModel.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceState.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceSummary.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/DetailPage/ClassModel.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/EditPage/StudentAttendance.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/FormPage/FormData.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/RealtimeAttendance/AttendanceMode.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/AttendanceReport.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/DialogHistoryReport/HistoryReportDialog.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/ReportData.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/WelcomePage.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/SecureStorage.dart';

class API {
  BuildContext context;
  API(this.context);

  Future<String> getAccessToken() async {
    SecureStorage secureStorage = SecureStorage();
    var accessToken = await secureStorage.readSecureData('accessToken');
    // print('alo alo accesss');
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

  Future<void> uploadFileExcel(File file) async {
    const URL = 'http://localhost:8080/';
    var request = http.MultipartRequest('POST', Uri.parse(URL));
    var multipartFile = await http.MultipartFile.fromPath('excel', file.path);
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded successfully');
    } else {
      print('Upload failed');
    }
  }

  Future<List<ReportData>> getReports() async {
    const URL = 'http://localhost:8080/api/teacher/reports'; //10.0.2.2

    var accessToken = await getAccessToken();
    var headers = {'authorization': accessToken};
    try {
      final response = await http.get(Uri.parse(URL), headers: headers);
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        List<ReportData> data = [];

        if (responseData is List) {
          for (var temp in responseData) {
            if (temp is Map<String, dynamic>) {
              try {
                data.add(ReportData.fromJson(temp));
              } catch (e) {
                print('Error parsing data: $e');
              }
            } else {
              print('Invalid data type: $temp');
            }
          }
        } else if (responseData is Map<String, dynamic>) {
          try {
            data.add(ReportData.fromJson(responseData));
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
            List<ReportData> data = [];

            if (responseData is List) {
              for (var temp in responseData) {
                if (temp is Map<String, dynamic>) {
                  try {
                    data.add(ReportData.fromJson(temp));
                  } catch (e) {
                    print('Error parsing data: $e');
                  }
                } else {
                  print('Invalid data type: $temp');
                }
              }
            } else if (responseData is Map<String, dynamic>) {
              try {
                data.add(ReportData.fromJson(responseData));
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
        print(
            'Failed to load reports data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<HistoryReportDialog?> getDetailHistoryReport(
      String classID, int historyReports) async {
    final url =
        'http://localhost:8080/api/teacher/historyreports/detail/$historyReports/$classID';
    var accessToken = await getAccessToken();
    var headers = {'authorization': accessToken};
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      // print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        HistoryReportDialog data = HistoryReportDialog.fromJson(responseData);
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
            HistoryReportDialog data =
                HistoryReportDialog.fromJson(responseData);

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

  Future<AttendanceReport?> getReportStudentClass(
      String classID, int reportID) async {
    final url =
        'http://localhost:8080/api/teacher/reports/detail/$reportID/$classID';
    var accessToken = await getAccessToken();
    var headers = {'authorization': accessToken};
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      // print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        AttendanceReport data = AttendanceReport.fromJson(responseData);
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
            AttendanceReport data = AttendanceReport.fromJson(responseData);

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

  Future<AttendanceModel?> getAttendanceDetailRealtime(String formID) async {
    final url = 'http://localhost:8080/api/teacher/attendance/detail/$formID';
    var accessToken = await getAccessToken();
    var headers = {'authorization': accessToken};
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      // print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        AttendanceModel data = AttendanceModel.fromJson(responseData);
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
            AttendanceModel data = AttendanceModel.fromJson(responseData);

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

  Future<bool> submitFeedback(
      int reportID, String topic, String message, String status) async {
    const url = 'http://localhost:8080/api/teacher/feedback/submit';
    var accessToken = await getAccessToken();
    var request = {
      'reportID': reportID,
      'topic': topic,
      'message': message,
      'confirmStatus': status,
    };
    var body = json.encode(request);
    var headers = {
      'authorization': accessToken,
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    try {
      print('body:$body');
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      // print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        String message = responseData['message'];
        print('message: $message');
        return true;
      } else if (response.statusCode == 498 || response.statusCode == 401) {
        var refreshToken = await SecureStorage().readSecureData('refreshToken');
        var newAccessToken = await refreshAccessToken(refreshToken);
        if (newAccessToken.isNotEmpty) {
          headers['authorization'] = newAccessToken;
          final retryResponse =
              await http.post(Uri.parse(url), headers: headers, body: body);
          if (retryResponse.statusCode == 200) {
            // print('-- RetryResponse.body ${retryResponse.body}');
            // print('-- Retry JsonDecode:${jsonDecode(retryResponse.body)}');
            dynamic responseData = jsonDecode(retryResponse.body);
            String message = responseData['message'];
            print('message retry: $message');
            // print('Data $data');
            return true;
          } else {
            return false;
          }
        } else {
          print('New Access Token is empty');
          return false;
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> editFeedback(
      int reportID, String topic, String message, String confirmStatus) async {
    final url = 'http://localhost:8080/api/teacher/feedback/edit/$reportID';
    var accessToken = await getAccessToken();
    var request = {
      'reportID': reportID,
      'topic': topic,
      'message': message,
      'confirmStatus': confirmStatus,
    };
    var body = json.encode(request);
    var headers = {
      'authorization': accessToken,
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    try {
      print('body:$body');
      final response =
          await http.put(Uri.parse(url), headers: headers, body: body);
      // print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        String message = responseData['message'];
        print('message: $message');
        return true;
      } else if (response.statusCode == 498 || response.statusCode == 401) {
        var refreshToken = await SecureStorage().readSecureData('refreshToken');
        var newAccessToken = await refreshAccessToken(refreshToken);
        if (newAccessToken.isNotEmpty) {
          headers['authorization'] = newAccessToken;
          final retryResponse =
              await http.put(Uri.parse(url), headers: headers, body: body);
          if (retryResponse.statusCode == 200) {
            // print('-- RetryResponse.body ${retryResponse.body}');
            // print('-- Retry JsonDecode:${jsonDecode(retryResponse.body)}');
            dynamic responseData = jsonDecode(retryResponse.body);
            String message = responseData['message'];
            print('message retry: $message');
            // print('Data $data');
            return true;
          } else {
            return false;
          }
        } else {
          print('New Access Token is empty');
          return false;
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<List<FormData>> getFormForTeacher(String classID) async {
    final URL =
        'http://localhost:8080/api/teacher/classes/detail/$classID/forms'; //10.0.2.2

    var accessToken = await getAccessToken();
    var headers = {
      'authorization': accessToken,
    };
    try {
      final response = await http.get(Uri.parse(URL), headers: headers);
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        List<FormData> data = [];

        if (responseData is List) {
          for (var temp in responseData) {
            if (temp is Map<String, dynamic>) {
              try {
                data.add(FormData.fromJson(temp));
              } catch (e) {
                print('Error parsing data: $e');
              }
            } else {
              print('Invalid data type: $temp');
            }
          }
        } else if (responseData is Map<String, dynamic>) {
          try {
            data.add(FormData.fromJson(responseData));
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
            List<FormData> data = [];

            if (responseData is List) {
              for (var temp in responseData) {
                if (temp is Map<String, dynamic>) {
                  try {
                    data.add(FormData.fromJson(temp));
                  } catch (e) {
                    print('Error parsing data: $e');
                  }
                } else {
                  print('Invalid data type: $temp');
                }
              }
            } else if (responseData is Map<String, dynamic>) {
              try {
                data.add(FormData.fromJson(responseData));
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

  Future<ClassModel?> getStudentsWithAllAttendanceDetails(
      String classID) async {
    final url = 'http://localhost:8080/api/teacher/classes/detail/$classID';
    var accessToken = await getAccessToken();
    var headers = {'authorization': accessToken};
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      // print(jsonDecode(response.body));
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

  Future<StudentAttendanceEdit?> getAttendanceDetailStudent(
      String classID, String studentID, String formID) async {
    final url =
        'http://localhost:8080/api/teacher/attendancedetail/$classID/$studentID/$formID';
    var accessToken = await getAccessToken();
    var headers = {'authorization': accessToken};
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      // print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        StudentAttendanceEdit data =
            StudentAttendanceEdit.fromJson(responseData);
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
            StudentAttendanceEdit data =
                StudentAttendanceEdit.fromJson(responseData);

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
