class FeedbackDetail {
   int? feedbackID;
   String? topic;
   String? message;
   String? confirmStatus;
   String? createdAt;

  FeedbackDetail({
     this.feedbackID =0,
     this.topic = '',
     this.message = '',
     this.confirmStatus = '',
     this.createdAt = '',
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
