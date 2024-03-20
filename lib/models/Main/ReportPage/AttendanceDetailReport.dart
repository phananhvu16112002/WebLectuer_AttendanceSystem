class AttendanceDetailReport {
  final String studentDetail;
  final String classDetail;
  final String attendanceForm;
  final String result;
  final String dateAttendanced;
  final String location;
  final String note;
  final double latitude;
  final double longitude;
  final String url;
  final String createdAt;

  AttendanceDetailReport({
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
  });

  factory AttendanceDetailReport.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailReport(
      studentDetail: json['studentDetail'],
      classDetail: json['classDetail'],
      attendanceForm: json['attendanceForm'],
      result: json['result'].toString(),
      dateAttendanced: json['dateAttendanced'] ?? '',
      location: json['location'],
      note: json['note'],
      latitude: double.parse(json['latitude'].toString()),
      longitude:double.parse( json['longitude'].toString()),
      url: json['url'],
      createdAt: json['createdAt'] ?? '',
    );
  }
}