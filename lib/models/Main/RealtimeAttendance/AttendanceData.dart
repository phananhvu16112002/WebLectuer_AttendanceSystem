class AttendanceData {
  final String studentID;
  final String classID;
  final String formID;
  String result;
  String dateAttendanced;
  final String location;
  final String note;
  final double latitude;
  final double longitude;
  final String url;
  final String createdAt;
  final String studentName;
  final String studentEmail;

  AttendanceData({
    required this.studentID,
    required this.classID,
    required this.formID,
    required this.result,
    required this.dateAttendanced,
    required this.location,
    required this.note,
    required this.latitude,
    required this.longitude,
    required this.url,
    required this.createdAt,
    required this.studentName,
    required this.studentEmail,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      studentID: json['studentID'] ?? '',
      classID: json['classID'] ?? '',
      formID: json['formID'] ?? '',
      result: json['result'].toString(),
      dateAttendanced: json['dateAttendanced'] ?? '',
      location: json['location'] ??'',
      note: json['note'] ?? '',
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      url: json['url'] ?? '',
      createdAt: json['createdAt'] ?? '',
      studentName: json['studentName'],
      studentEmail: json['studentEmail'],
    );
  }
}
