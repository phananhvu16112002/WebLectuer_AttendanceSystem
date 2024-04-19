class ReportNotifications {
  int? reportID;
  String? topic;
  String? problem;
  String? message;
  String? status;
  String? createdAt;
  int? isNew;
  int? isImportant;
  String? studentID;
  String? classID;
  String? formID;

  ReportNotifications({
    this.reportID = 0,
    this.topic = '',
    this.problem = '',
    this.message = '',
    this.status = '',
    this.createdAt = '',
    this.isNew = 0,
    this.isImportant = 0,
    this.studentID = '',
    this.classID = '',
    this.formID = '',
  });

  factory ReportNotifications.fromJson(Map<String, dynamic> json) {
    return ReportNotifications(
      reportID: json['report_reportID'],
      topic: json['report_topic'],
      problem: json['report_problem'],
      message: json['report_message'],
      status: json['report_status'],
      createdAt: json['report_createdAt'],
      isNew: json['report_new'],
      isImportant: json['report_important'],
      studentID: json['report_studentID'],
      classID: json['report_classID'],
      formID: json['report_formID'],
    );
  }
}
