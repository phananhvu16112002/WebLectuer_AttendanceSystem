import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';

class SelectedPageProvider with ChangeNotifier {
  bool checkHome = true;
  bool checkReport = false;
  bool checkNoti = false;
  bool checkForm = false;
  bool checkAttendanceForm = false;
  bool checkEditAttendanceForm = false;
  bool checkEditAttendanceDetail = false;
  bool checkChart = false;

  bool get getCheckEditAttendanceForm => checkEditAttendanceForm;
  bool get getCheckHome => checkHome;
  bool get getCheckReport => checkReport;
  bool get getCheckNoti => checkNoti;
  bool get getCheckForm => checkForm;
  bool get getCheckAttendanceForm => checkAttendanceForm;
  bool get getCheckAttendanceDetail => checkEditAttendanceDetail;
  bool get getCheckChart => checkChart;

  void setCheckEditAttendanceForm(bool check) {
    checkEditAttendanceForm = check;
    notifyListeners();
  }

  void setCheckHome(bool check) {
    checkHome = check;
    notifyListeners();
  }

  void setCheckReport(bool check) {
    checkReport = check;
    notifyListeners();
  }

  void setCheckForm(bool check) {
    checkForm = check;
    notifyListeners();
  }

  void setCheckAttendanceForm(bool check) {
    checkAttendanceForm = check;
    notifyListeners();
  }

  void setCheckNoti(bool check) {
    checkNoti = check;
    notifyListeners();
  }

  void setCheckAttendanceDetail(bool check) {
    checkEditAttendanceDetail = check;
    notifyListeners();
  }

  void setCheckChart(bool check) {
    checkChart = check;
    notifyListeners();
  }
}
