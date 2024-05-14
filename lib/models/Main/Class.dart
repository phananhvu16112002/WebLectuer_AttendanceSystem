import 'package:weblectuer_attendancesystem_nodejs/models/Main/Course.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Teacher.dart';

class Class {
   String? classID;
   String? roomNumber;
   int? shiftNumber;
   String? startTime;
   String? endTime;
   String? classType;
   String? group;
   String? subGroup;
   Teacher? teacher;
   Course? course;

  Class({
     this.classID = '',
     this.roomNumber = '',
     this.shiftNumber = 0,
     this.startTime = '',
     this.endTime = '',
     this.classType = '',
     this.group = '',
     this.subGroup = '',
     this.teacher ,
     this.course,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    // print('Class.fromJson: $json');
    return Class(
      classID: json['classID'],
      roomNumber: json['roomNumber'] ?? "",
      shiftNumber: json['shiftNumber'] as int? ?? 0,
      startTime: json['startTime'] ?? "",
      endTime: json['endTime'] ?? "",
      classType: json['classType'] ?? "",
      group: json['group'] ?? "",
      subGroup: json['subGroup'] ?? "",
      teacher: Teacher.fromJson(json['teacher'] ?? {}),
      course: Course.fromJson(json['course'] ?? {}),
    );
  }
}
