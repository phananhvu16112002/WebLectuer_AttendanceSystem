import 'package:weblectuer_attendancesystem_nodejs/models/Main/DetailPage/ClassData.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/DetailPage/StudentData.dart';

class ClassModel {
  ClassData classData;
  List<StudentData> data;

  ClassModel({required this.classData, required this.data});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      classData: ClassData.fromJson(json['classData']),
      data: List<StudentData>.from(
          json['data'].map((x) => StudentData.fromJson(x))),
    );
  }
}
