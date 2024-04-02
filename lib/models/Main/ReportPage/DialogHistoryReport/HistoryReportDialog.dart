import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/DialogHistoryReport/HistoryFeedback.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/DialogHistoryReport/HistoryReportImage.dart';

class HistoryReportDialog {
  final int? historyReportID;
  final String? topic;
  final String? problem;
  final String? message;
  final String? status;
  final String? createdAt;
  final HistoryFeedback? historyFeedbacks;
  final List<HistoryReportImage>? historyReportImages;

  HistoryReportDialog({
    this.historyReportID = 0,
    this.topic = '',
    this.problem = '',
    this.message = ' ',
    this.status = '',
    this.createdAt = '',
    this.historyFeedbacks,
    this.historyReportImages,
  });

  factory HistoryReportDialog.fromJson(Map<String, dynamic> json) {
    return HistoryReportDialog(
      historyReportID: json['historyReportID'],
      topic: json['topic'],
      problem: json['problem'],
      message: json['message'],
      status: json['status'],
      createdAt: json['createdAt'] ?? '',
      historyFeedbacks: json['historyFeedbacks'] != null
          ? HistoryFeedback.fromJson(json['historyFeedbacks'])
          : null,
      historyReportImages: (json['historyReportImages'] as List<dynamic>)
          .map((image) => HistoryReportImage.fromJson(image))
          .toList(),
    );
  }
}
