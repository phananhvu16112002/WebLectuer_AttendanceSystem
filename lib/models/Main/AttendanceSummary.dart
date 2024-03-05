import 'package:weblectuer_attendancesystem_nodejs/models/Main/StudentAttendance.dart';

class AttendanceSummary {
  final List<StudentAttendance> data;
  final int all;
  final int present;
  final int absent;
  final int late;

  AttendanceSummary({
    required this.data,
    required this.all,
    required this.present,
    required this.absent,
    required this.late,
  });

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) {
    return AttendanceSummary(
      data: List<StudentAttendance>.from(
          json['data'].map((x) => StudentAttendance.fromJson(x))),
      all: json['all'],
      present: json['present'],
      absent: json['absent'],
      late: json['late'],
    );
  }
}
