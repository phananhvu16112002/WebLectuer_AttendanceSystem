class HistoryReport {
  final int historyReportID;
  final String topic;
  final String problem;
  final String message;
  final String status;
  final String createdAt;

  HistoryReport({
    required this.historyReportID,
    required this.topic,
    required this.problem,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  factory HistoryReport.fromJson(Map<String, dynamic> json) {
    return HistoryReport(
      historyReportID: json['historyReportID'],
      topic: json['topic'],
      problem: json['problem'],
      message: json['message'],
      status: json['status'],
      createdAt: json['createdAt'] ?? '',
    );
  }
}
