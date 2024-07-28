import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';

class ActivateFormDataProvider with ChangeNotifier {
  Class _classData = Class();
  String _formID = '';

  Class get classData => _classData;
  String get formId => _formID;


  void setClassData(Class classData) {
    _classData = classData;
    notifyListeners();
  }

   void setFormId(String formId) {
    _formID = formId;
    notifyListeners();
  }

}