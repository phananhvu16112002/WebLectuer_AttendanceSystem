import 'package:flutter/material.dart';

class EditAttendanceDetailProvider with ChangeNotifier {
  String? studentID;
  String? formID;
  String? studentName;

  String? get getStudentID => studentID;
  String? get getFormID => formID;
  String? get getStudentName => studentName;

  void setStudentID(String data) {
    studentID = data;
    notifyListeners();
  }

  void setFormID(String data) {
    formID = data;
    notifyListeners();
  }

  void setStudentName(String data) {
    studentName = data;
    notifyListeners();
  }
}
