class ReportImage {
  final String imageID;
  final String imageURL;

  ReportImage({required this.imageID, required this.imageURL});

  factory ReportImage.fromJson(Map<String, dynamic> json) {
    return ReportImage(
      imageID: json['imageID'],
      imageURL: json['imageURL'],
    );
  }
}
