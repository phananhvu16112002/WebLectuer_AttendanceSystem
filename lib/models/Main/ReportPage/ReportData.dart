class ReportData {
  String? classID;
  String? roomNumber;
  int? shiftNumber;
  String? startTime;
  String? endTime;
  String? classType;
  String? group;
  String? subGroup;
  String? courseID;
  String? teacherID;
  String? courseName;
  int? totalWeeks;
  int? Weeks;
  int? credit;
  int? reportID;
  String? topic;
  String? problem;
  String? message;
  String? status;
  String? createdAt;
  int? isNew;
  int? isImportant;
  String? studentID;
  String? formID;
  String? studentEmail;
  String? studentName;

  ReportData({
    this.classID,
    this.roomNumber,
    this.shiftNumber,
    this.startTime,
    this.endTime,
    this.classType,
    this.group,
    this.subGroup,
    this.courseID,
    this.teacherID,
    this.courseName,
    this.totalWeeks,
    this.Weeks,
    this.credit,
    this.reportID,
    this.topic,
    this.problem,
    this.message,
    this.status,
    this.createdAt,
    this.isNew,
    this.isImportant,
    this.studentID,
    this.formID,
    this.studentEmail,
    this.studentName,
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
      totalWeeks: int.parse(json['totalWeeks'].toString()),
      Weeks: json['Weeks'],
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
