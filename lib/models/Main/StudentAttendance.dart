
class StudentAttendance {
  final String studentDetail;
  final String classDetail;
  final String attendanceForm;
  late dynamic result;
  final String dateAttendanced;
  final String location;
  final String note;
  final double latitude;
  final double longitude;
  final String url;

  StudentAttendance({
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
  });

  factory StudentAttendance.fromJson(Map<String, dynamic> json) {
    return StudentAttendance(
      studentDetail: json['studentDetail'],
      classDetail: json['classDetail'],
      attendanceForm: json['attendanceForm'],
      result: json['result'],
      dateAttendanced: json['dateAttendanced'],
      location: json['location'],
      note: json['note'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      url: json['url'],
    );
  }
}
