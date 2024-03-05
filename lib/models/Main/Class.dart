import 'package:weblectuer_attendancesystem_nodejs/models/Main/Course.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Teacher.dart';

class Class {
  final String classID;
  final String roomNumber;
  final int shiftNumber;
  final String? startTime;
  final String? endTime;
  final String classType;
  final String group;
  final String subGroup;
  final Teacher teacher;
  final Course course;

  Class({
    required this.classID,
    required this.roomNumber,
    required this.shiftNumber,
    required this.startTime,
    required this.endTime,
    required this.classType,
    required this.group,
    required this.subGroup,
    required this.teacher,
    required this.course,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    print('Class.fromJson: $json');
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
