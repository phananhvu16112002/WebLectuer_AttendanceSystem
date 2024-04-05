class HistoryEdition {
   int? feedbackID;
   String? topic;
   String? message;
   String? confirmStatus;
   String? createdAt;

  HistoryEdition({
     this.feedbackID = 0,
     this.topic = '',
     this.message = '',
     this.confirmStatus = '',
     this.createdAt = '',
  });

  factory HistoryEdition.fromJson(Map<String, dynamic> json) {
    return HistoryEdition(
      feedbackID: json['feedbackID'] ?? 0,
      topic: json['topic'] ?? '',
      message: json['message'] ?? '',
      confirmStatus: json['confirmStatus'] ??'', 
      createdAt: json['createdAt'] ?? '',
    );
  }
}
