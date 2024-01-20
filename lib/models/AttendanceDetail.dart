import 'package:weblectuer_attendancesystem_nodejs/models/StudentClasses.dart';

class AttendanceDetail {
  StudentClasses studentClassesDetail;
  String classes;
  String attendanceForm; //FormID
  bool present;
  bool late;
  bool absence;
  DateTime? dateAttendanced;
  String location;
  String note;
  int latitude;
  int longitude;
  int altitude;

  AttendanceDetail({
    required this.studentClassesDetail,
    required this.classes,
    required this.attendanceForm,
    required this.present,
    required this.late,
    required this.absence,
    required this.dateAttendanced,
    required this.location,
    required this.note,
    required this.latitude,
    required this.longitude,
    required this.altitude,
  });

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) {
    print('AttendanceDetail.fromJson: $json');

    return AttendanceDetail(
      studentClassesDetail:
          StudentClasses.fromJson(json['studentDetail'] ?? {}),
      classes: json['classes'] ?? "",
      attendanceForm: json['attendanceForm'] ?? "",
      present: json['present'] ?? false,
      late: json['late'] ?? false,
      absence: json['absence'] ?? false,
      dateAttendanced: json['dateAttendanced'] != null
          ? DateTime.tryParse(json['dateAttendanced'])
          : null,
      location: json['location'] ?? "",
      note: json['note'] ?? "",
      latitude:
          json['latitude'] != null ? int.tryParse(json['latitude']) ?? 0 : 0,
      longitude:
          json['longitude'] != null ? int.tryParse(json['longitude']) ?? 0 : 0,
      altitude:
          json['altitude'] != null ? int.tryParse(json['altitude']) ?? 0 : 0,
    );
  }
}
