import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceForm.dart';

class EditAttendanceFormProvider with ChangeNotifier {
  AttendanceForm _attendanceForm = AttendanceForm(
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

  AttendanceForm get attendanceForm => _attendanceForm;

  void setAttendanceForm(AttendanceForm attendanceForm) {
    _attendanceForm = attendanceForm;
    notifyListeners();
  }
}
