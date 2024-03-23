class HistoryFeedback {
  final int historyFeedbackID;
  final String topic;
  final String message;
  final String confirmStatus;
  final String createdAt;

  HistoryFeedback({
    required this.historyFeedbackID,
    required this.topic,
    required this.message,
    required this.confirmStatus,
    required this.createdAt,
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
