class AttendanceDetail {
  final String attendanceForm;
  final int result;
  final String? dateAttendanced;
  final String location;
  final String note;
  final String url;

  AttendanceDetail({
    required this.attendanceForm,
    required this.result,
    required this.dateAttendanced,
    required this.location,
    required this.note,
    required this.url,
  });

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) {
    return AttendanceDetail(
      attendanceForm: json['attendanceForm'],
      result: json['result'],
      dateAttendanced: json['dateAttendanced'],
      location: json['location'],
      note: json['note'],
      url: json['url'],
    );
  }
}
