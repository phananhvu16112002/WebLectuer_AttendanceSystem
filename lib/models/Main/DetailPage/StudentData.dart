import 'package:weblectuer_attendancesystem_nodejs/models/Main/DetailPage/AttendanceDetailForDetailPage.dart';

class StudentData {
  List<AttendanceDetailForDetailPage> attendancedetails;
  String status;
  String total;
  String studentID;
  String studentName;
  String studentEmail;

  StudentData({
    required this.attendancedetails,
    required this.status,
    required this.total,
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
      total: json['total'],
      studentID: json['studentID'],
      studentName: json['studentName'],
      studentEmail: json['studentEmail'],
    );
  }
}
