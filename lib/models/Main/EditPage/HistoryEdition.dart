class HistoryEdition {
  final int feedbackID;
  final String topic;
  final String message;
  final String confirmStatus;
  final String createdAt;

  HistoryEdition({
    required this.feedbackID,
    required this.topic,
    required this.message,
    required this.confirmStatus,
    required this.createdAt,
  });

  factory HistoryEdition.fromJson(Map<String, dynamic> json) {
    return HistoryEdition(
      feedbackID: json['feedbackID'],
      topic: json['topic'],
      message: json['message'],
      confirmStatus: json['confirmStatus'],
      createdAt: json['createdAt'],
    );
  }
}
