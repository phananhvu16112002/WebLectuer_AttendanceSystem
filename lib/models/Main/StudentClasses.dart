import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceDetail.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Student.dart';

class StudentClasses {
  Student student;
  List<AttendanceDetail> attendanceDetail;
  String status;

  StudentClasses(
      {required this.student,
      required this.attendanceDetail,
      required this.status});
  factory StudentClasses.fromJson(Map<String, dynamic> json) {
    return StudentClasses(
      student: Student.fromJson(json['studentDetail']),
      attendanceDetail: List<AttendanceDetail>.from(json['attendanceDetail']
          .map((attendanceDetailJson) =>
              AttendanceDetail.fromJson(attendanceDetailJson))),
      status: json['status'] ?? '',
    );
  }
}
