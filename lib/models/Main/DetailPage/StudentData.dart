class StudentData {
  List<dynamic> attendancedetails;
  String status;
  String studentID;
  String studentName;
  String studentEmail;

  StudentData(
      {required this.attendancedetails,
      required this.status,
      required this.studentID,
      required this.studentName,
      required this.studentEmail});

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      attendancedetails: json['attendancedetails'],
      status: json['status'],
      studentID: json['studentID'],
      studentName: json['studentName'],
      studentEmail: json['studentEmail'],
    );
  }
}
