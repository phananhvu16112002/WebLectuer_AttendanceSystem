import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:weblectuer_attendancesystem_nodejs/models/AttendanceForm.dart';

class SocketServerProvider with ChangeNotifier {
  late IO.Socket _socket;
  bool _isConnected = false;

  IO.Socket get socket => _socket;
  bool get isConnected => _isConnected;

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
      "longtitude": attendanceForm.longtitude,
      "radius": attendanceForm.radius
    };
    var jsonString = jsonEncode(jsonData);
    print('---jsonString: $jsonString');
    _socket.emit('sendAttendanceForm', jsonString);
  }

  void disconnectSocketServer() {
    _socket.disconnect();
    _isConnected = false;
    notifyListeners();
  }
}
