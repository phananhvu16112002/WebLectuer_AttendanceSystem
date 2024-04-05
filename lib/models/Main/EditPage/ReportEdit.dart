class ReportEdit {
  int? reportID;
  String? topic;
  String? problem;
  String? message;
  String? status;
  String? createdAt;
  bool? newReport;
  bool? important;

  ReportEdit(
      {this.reportID = 0,
      this.topic = '',
      this.problem = '',
      this.message = '',
      this.status = '',
      this.createdAt = '',
      this.newReport = false,
      this.important = false});

  factory ReportEdit.fromJson(Map<String, dynamic> json) {
    return ReportEdit(
      reportID: json['reportID'] ?? '',
      topic: json['topic'] ?? '',
      problem: json['problem'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      newReport: json['new'] ?? false,
      important: json['important'] ?? false,
    );
  }
}
