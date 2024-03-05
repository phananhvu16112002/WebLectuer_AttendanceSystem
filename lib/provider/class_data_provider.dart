import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';

class ClassDataProvider with ChangeNotifier {
  List<Class> _classList = [];

  List<Class> get classData => _classList;

  void setAttendanceFormData(List<Class> dataClass) {
    _classList = dataClass;
    notifyListeners();
  }
}
