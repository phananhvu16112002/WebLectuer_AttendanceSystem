class HistoryReport {
  final int? historyReportID;
  final String? topic;
  final String? problem;
  final String? message;
  final String? status;
  final String? createdAt;

  HistoryReport({
    this.historyReportID = 0,
    this.topic = '',
    this.problem = '',
    this.message = '',
    this.status = '',
    this.createdAt = '',
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
