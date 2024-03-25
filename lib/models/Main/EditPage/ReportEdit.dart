class ReportEdit {
  final int reportID;
  final String topic;
  final String problem;
  final String message;
  final String status;
  final String createdAt;
  final bool newReport;
  final bool important;

  ReportEdit({
    required this.reportID,
    required this.topic,
    required this.problem,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.newReport,
    required this.important,
  });

  factory ReportEdit.fromJson(Map<String, dynamic> json) {
    return ReportEdit(
      reportID: json['reportID'],
      topic: json['topic'],
      problem: json['problem'],
      message: json['message'],
      status: json['status'],
      createdAt: json['createdAt'],
      newReport: json['new'],
      important: json['important'],
    );
  }
}
