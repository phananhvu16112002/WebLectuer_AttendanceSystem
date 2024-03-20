class ReportData {
  final String classID;
  final String roomNumber;
  final int shiftNumber;
  final String startTime;
  final String endTime;
  final String classType;
  final String group;
  final String subGroup;
  final String courseID;
  final String teacherID;
  final String courseName;
  final int totalWeeks;
  final int requiredWeeks;
  final int credit;
  final int reportID;
  final String topic;
  final String problem;
  final String message;
  final String status;
  final String createdAt;
  final int isNew;
  final int isImportant;
  final String studentID;
  final String formID;
  final String studentEmail;
  final String studentName;

  ReportData({
    required this.classID,
    required this.roomNumber,
    required this.shiftNumber,
    required this.startTime,
    required this.endTime,
    required this.classType,
    required this.group,
    required this.subGroup,
    required this.courseID,
    required this.teacherID,
    required this.courseName,
    required this.totalWeeks,
    required this.requiredWeeks,
    required this.credit,
    required this.reportID,
    required this.topic,
    required this.problem,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.isNew,
    required this.isImportant,
    required this.studentID,
    required this.formID,
    required this.studentEmail,
    required this.studentName,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      classID: json['classID'],
      roomNumber: json['roomNumber'],
      shiftNumber: json['shiftNumber'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      classType: json['classType'],
      group: json['group'],
      subGroup: json['subGroup'],
      courseID: json['courseID'],
      teacherID: json['teacherID'],
      courseName: json['courseName'],
      totalWeeks: json['totalWeeks'],
      requiredWeeks: json['requiredWeeks'],
      credit: json['credit'],
      reportID: json['reportID'],
      topic: json['topic'],
      problem: json['problem'],
      message: json['message'],
      status: json['status'],
      createdAt: json['createdAt'],
      isNew: json['new'],
      isImportant: json['important'],
      studentID: json['studentID'],
      formID: json['formID'],
      studentEmail: json['studentEmail'],
      studentName: json['studentName'],
    );
  }
}
