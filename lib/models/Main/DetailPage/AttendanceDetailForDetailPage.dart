class AttendanceDetailForDetailPage {
  final String studentDetail;
  final String classDetail;
  final String attendanceForm;
  final double result;
  final String dateAttendanced;
  final String location;
  final String note;
  final double latitude;
  final double longitude;
  final String url;
  final String createdAt;

  AttendanceDetailForDetailPage({
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

  factory AttendanceDetailForDetailPage.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailForDetailPage(
      studentDetail: json['studentDetail'],
      classDetail: json['classDetail'],
      attendanceForm: json['attendanceForm'],
      result: double.parse(json['result'].toString()),
      dateAttendanced: json['dateAttendanced'] ?? '',
      location: json['location'],
      note: json['note'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      url: json['url'],
      createdAt: json['createdAt'] ?? '',
    );
  }
}
