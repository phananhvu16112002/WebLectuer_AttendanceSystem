class HistoryFeedback {
  final int? historyFeedbackID;
  final String? topic;
  final String? message;
  final String? confirmStatus;
  final String? createdAt;

  HistoryFeedback({
    this.historyFeedbackID = 0,
    this.topic = '',
    this.message = '',
    this.confirmStatus = '',
    this.createdAt = '',
  });

  factory HistoryFeedback.fromJson(Map<String, dynamic> json) {
    return HistoryFeedback(
      historyFeedbackID: json['historyFeedbackID'],
      topic: json['topic'],
      message: json['message'],
      confirmStatus: json['confirmStatus'],
      createdAt: json['createdAt'] ?? '',
    );
  }
}
