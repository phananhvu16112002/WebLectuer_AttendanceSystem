import 'package:weblectuer_attendancesystem_nodejs/models/Main/EditPage/HistoryEdition.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/EditPage/ReportEdit.dart';

class StudentAttendanceEdit {
  final String? studentDetail;
  final String? classDetail;
  final String? attendanceForm;
  final String? result;
  final String? dateAttendanced;
  final String? location;
  final String? note;
  final double? latitude;
  final double? longitude;
  final String? url;
  final String? createdAt;
  final List<HistoryEdition>? histories;
  final ReportEdit? report;

  StudentAttendanceEdit({
    this.studentDetail = '',
    this.classDetail = '',
    this.attendanceForm = '',
    this.result = '',
    this.dateAttendanced = '',
    this.location = '',
    this.note = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.url = '',
    this.createdAt = '',
    this.histories,
    this.report,
  });

  factory StudentAttendanceEdit.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceEdit(
      studentDetail: json['studentDetail'],
      classDetail: json['classDetail'],
      attendanceForm: json['attendanceForm'],
      result: json['result'].toString(),
      dateAttendanced: json['dateAttendanced'],
      location: json['location'],
      note: json['note'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      url: json['url'],
      createdAt: json['createdAt'],
      histories: List<HistoryEdition>.from(
          json['histories'].map((x) => HistoryEdition.fromJson(x))),
      report:
          json['report'] != null ? ReportEdit.fromJson(json['report']) : null,
    );
  }
}
