import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/AttendanceForm.dart';

class AttendanceFormDataProvider with ChangeNotifier {
  List<AttendanceForm> _attendanceFormList =[];

  List<AttendanceForm> get attendanceFormData => _attendanceFormList;

  void setAttendanceFormData(List<AttendanceForm> attendanceForm) {
    _attendanceFormList = attendanceForm;
    notifyListeners();
  }
}
