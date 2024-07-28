import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Course.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Teacher.dart';

class ClassData {
  Class? classes;
  int? total;
  int? pass;
  int? ban;
  int? warning;
  int? totalWeeks;

  ClassData({
     this.classes,
     this.total,
     this.pass,
     this.ban,
     this.warning,
     this.totalWeeks,
  });

  factory ClassData.fromJson(Map<String, dynamic> json) {
    return ClassData(
      classes: Class(
        classID: json['classID'],
        roomNumber: json['roomNumber'],
        shiftNumber: json['shiftNumber'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        classType: json['classType'],
        group: json['group'],
        subGroup: json['subGroup'],
        teacher: Teacher.fromJson(json['teacher']),
        course: Course.fromJson(json['course']),
      ),
      total: json['total'],
      pass: json['pass'],
      ban: json['ban'],
      warning: json['warning'],
      totalWeeks: json['totalWeeks']
    );
  }
}
