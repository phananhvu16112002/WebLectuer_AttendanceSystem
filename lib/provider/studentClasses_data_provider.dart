import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/StudentClasses.dart';

class StudentClassesDataProvider with ChangeNotifier {
  List<StudentClasses> _studentClassesList = [];

  List<StudentClasses> get studentClassesData => _studentClassesList;

  void setStudentClassesData(List<StudentClasses> studentClasses) {
    _studentClassesList = studentClasses;
    print('Successfully Updated Data Provider');
    notifyListeners();
  }
}
