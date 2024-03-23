class HistoryReportImage {
  final int historyReportImageID;
  final String imageURL;

  HistoryReportImage({
    required this.historyReportImageID,
    required this.imageURL,
  });

  factory HistoryReportImage.fromJson(Map<String, dynamic> json) {
    return HistoryReportImage(
      historyReportImageID: json['historyReportImageID'],
      imageURL: json['imageURL'],
    );
  }
}