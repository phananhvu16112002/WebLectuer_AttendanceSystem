import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceForm.dart';

class AttendanceFormDataProvider with ChangeNotifier {
  AttendanceForm _attendanceFormList = AttendanceForm(
      formID: '',
      classes: '',
      startTime: '',
      endTime: '',
      dateOpen: '',
      status: false,
      typeAttendance: 0,
      location: '',
      latitude: 0.0,
      longtitude: 0.0,
      radius: 0.0);

  AttendanceForm get attendanceFormData => _attendanceFormList;

  void setAttendanceFormData(AttendanceForm attendanceForm) {
    _attendanceFormList = attendanceForm;
    notifyListeners();
  }
}
