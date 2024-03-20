import 'package:weblectuer_attendancesystem_nodejs/models/Main/DetailPage/AttendanceDetailForDetailPage.dart';

class StudentData {
  List<AttendanceDetailForDetailPage> attendancedetails;
  String status;
  String studentID;
  String studentName;
  String studentEmail;

  StudentData({
    required this.attendancedetails,
    required this.status,
    required this.studentID,
    required this.studentName,
    required this.studentEmail,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    List<dynamic> attendanceDetailsJson = json['attendancedetails'];
    List<AttendanceDetailForDetailPage> attendanceDetails =
        attendanceDetailsJson
            .map((detailJson) =>
                AttendanceDetailForDetailPage.fromJson(detailJson))
            .toList();

    return StudentData(
      attendancedetails: attendanceDetails,
      status: json['status'],
      studentID: json['studentID'],
      studentName: json['studentName'],
      studentEmail: json['studentEmail'],
    );
  }
}
