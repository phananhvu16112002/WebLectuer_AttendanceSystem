import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceForm.dart';

class SocketServerProvider with ChangeNotifier {
  late IO.Socket _socket;
  bool _isConnected = false;

  IO.Socket get socket => _socket;
  bool get isConnected => _isConnected;

  final StreamController<Map<String, dynamic>>
      _attendanceDetailStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get attendanceStream =>
      _attendanceDetailStreamController.stream;

  void connectToSocketServer(data) {
    _socket = IO.io('http://localhost:9000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'headers': {'Content-Type': 'application/json'},
    });

    _socket.connect();
    _isConnected = true;
    joinClassRoom(data);
    notifyListeners();
  }

  void joinClassRoom(data) {
    var jsonData = {'classRoom': data};
    var jsonString = jsonEncode(jsonData);
    print('---jsonStringJoin $jsonString');
    print("Sending joinClassRoom event with data: $jsonString");
    _socket.emit('joinClassRoom', jsonString);
  }

  void sendAttendanceForm(AttendanceForm attendanceForm) {
    print('Attendance Form Model: ${attendanceForm.toString()}');
    var jsonData = {
      "formID": attendanceForm.formID,
      "classes": attendanceForm.classes,
      "startTime": attendanceForm.startTime,
      "endTime": attendanceForm.endTime,
      "dateOpen": attendanceForm.dateOpen,
      "status": attendanceForm.status,
      "type": attendanceForm.typeAttendance,
      "location": attendanceForm.location,
      "latitude": attendanceForm.latitude,
      "longitude": attendanceForm.longtitude,
      "radius": attendanceForm.radius
    };

    var jsonString = jsonEncode(jsonData);
    print("FormID Socket: ${attendanceForm.formID}");
    print("Classes Socket: ${attendanceForm.classes}");
    print("DateOpen Socket: ${attendanceForm.dateOpen}");
    print("Latitude Socket ${attendanceForm.latitude}");
    print("Longitude Socket: ${attendanceForm.longtitude}");
    print('---jsonString: $jsonString');
    _socket.emit('sendAttendanceForm', jsonString);
  }

  void getAttendanceDetail() {
    _socket.on('getTakeAttendance', (data) {
      try {
        print('Data: $data');
        var temp = jsonDecode(data);
        print(temp);
        var jsonData = {
          'studentDetail': temp['studentDetail'],
          'classDetail': temp['classDetail'],
          'dateTimeAttendance': temp['dateTimeAttendance'],
          'result': temp['result'].toString(),
        };
        _attendanceDetailStreamController.add(jsonData);
      } catch (e) {
        print('Error: $e');
      }
    });
  }

  void disconnectSocketServer() {
    _socket.disconnect();
    _isConnected = false;
    notifyListeners();
  }
}






  // late Map<String, int> _attendanceStatistics = {
  //   'Present': 0,
  //   'Absent': 0,
  //   'Late': 0
  // };
  // Map<String, int> get attendanceStatistics => _attendanceStatistics;

  // StreamController<Map<String, int>> _attendanceStreamController =
  //     StreamController<Map<String, int>>.broadcast();






    // void getAttendanceDetail() {
  //   _socket.on('getTakeAttendance', (data) {
  //     print('Data from socket: $data');
  //     var temp = jsonDecode(data);
  //     String result = temp['result'].toString();
      
  //     print('Result from socket: $result');
  //     if (result == '1') {
  //       attendanceStatistics.update('Present', (value) => value + 1,
  //           ifAbsent: () => 1);
  //     } else if (result == '0') {
  //       attendanceStatistics.update('Absent', (value) => value + 1,
  //           ifAbsent: () => 1);
  //     } else if (result.toString() == '0.5') {
  //       attendanceStatistics.update('Late', (value) => value + 1,
  //           ifAbsent: () => 1);
  //     }
  //     _attendanceStreamController.add(attendanceStatistics);
  //   });
  // }