import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Teacher.dart';

class TeacherDataProvider with ChangeNotifier {
  Teacher _teacher = Teacher(
      teacherID: '',
      teacherName: '',
      teacherHashedPassword: '',
      teacherEmail: '',
      teacherHashedOTP: '',
      timeToLiveOTP: '',
      accessToken: '',
      refreshToken: '',
      resetToken: '',
      active: false);

  Teacher get userData => _teacher;

  void setTeacherID(String teacherID) {
    _teacher.teacherID = teacherID;
  }

  void setTeacherEmail(String teacherEmail) {
    _teacher.teacherEmail = teacherEmail;
  }

  void setTeacherName(String teacherName) {
    _teacher.teacherName = teacherName;
  }

  void setOTP(String hasedOTP) {
    _teacher.teacherHashedOTP = hasedOTP;
  }

  void setTeacherData(Teacher data) {
    _teacher = data;
    notifyListeners();
  }
}
