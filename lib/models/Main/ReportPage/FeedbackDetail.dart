class FeedbackDetail {
  final int feedbackID;
  final String topic;
  final String message;
  final String confirmStatus;
  final String createdAt;

  FeedbackDetail({
    required this.feedbackID,
    required this.topic,
    required this.message,
    required this.confirmStatus,
    required this.createdAt,
  });

  factory FeedbackDetail.fromJson(Map<String, dynamic> json) {
    // if (json.isEmpty || json == null) {
    //   return FeedbackDetail(
    //     feedbackID: 0,
    //     topic: '',
    //     message: '',
    //     confirmStatus: '',
    //     createdAt: '',
    //   );
    // }

    return FeedbackDetail(
      feedbackID: json['feedbackID'] ?? 0,
      topic: json['topic'] ?? '',
      message: json['message'] ?? '',
      confirmStatus: json['confirmStatus'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
