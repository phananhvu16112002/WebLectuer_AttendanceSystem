import 'package:weblectuer_attendancesystem_nodejs/models/Main/EditPage/HistoryEdition.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/EditPage/ReportEdit.dart';

class StudentAttendanceEdit {
  final String studentDetail;
  final String classDetail;
  final String attendanceForm;
  final String result;
  final DateTime dateAttendanced;
  final String location;
  final String note;
  final double latitude;
  final double longitude;
  final String url;
  final DateTime createdAt;
  final List<HistoryEdition> histories;
  final ReportEdit? report;

  StudentAttendanceEdit({
    required this.studentDetail,
    required this.classDetail,
    required this.attendanceForm,
    required this.result,
    required this.dateAttendanced,
    required this.location,
    required this.note,
    required this.latitude,
    required this.longitude,
    required this.url,
    required this.createdAt,
    required this.histories,
    required this.report,
  });

  factory StudentAttendanceEdit.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceEdit(
      studentDetail: json['studentDetail'],
      classDetail: json['classDetail'],
      attendanceForm: json['attendanceForm'],
      result: json['result'].toString(),
      dateAttendanced: DateTime.parse(json['dateAttendanced']),
      location: json['location'],
      note: json['note'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      url: json['url'],
      createdAt: DateTime.parse(json['createdAt']),
      histories: List<HistoryEdition>.from(
          json['histories'].map((x) => HistoryEdition.fromJson(x))),
      report:
          json['report'] != null ? ReportEdit.fromJson(json['report']) : null,
    );
  }
}
