import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/AttendanceForm.dart';

class AttendanceFormDataProvider with ChangeNotifier {
  late AttendanceForm _attendanceFormData;

  AttendanceForm get attendanceFormData => _attendanceFormData;

  void setAttendanceFormData(AttendanceForm attendanceForm) {
    _attendanceFormData = attendanceForm;
    notifyListeners();
  }
}
