import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/AttendanceDetailReport.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/FeedbackDetail.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/HistoryReport.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/ReportImage.dart';

class AttendanceReport {
  final int reportID;
  final String topic;
  final String problem;
  final String message;
  final String status;
  final String createdAt;
  final bool isNew;
  final bool isImportant;
  AttendanceDetailReport attendanceDetail;
  final FeedbackDetail? feedback;
  final List<HistoryReport> historyReports;
  final List<ReportImage> reportImages;

  AttendanceReport(
      {required this.reportID,
      required this.topic,
      required this.problem,
      required this.message,
      required this.status,
      required this.createdAt,
      required this.isNew,
      required this.isImportant,
      required this.attendanceDetail,
      required this.feedback,
      required this.historyReports,
      required this.reportImages});

  factory AttendanceReport.fromJson(Map<String, dynamic> json) {
    // print('Feedback: ${json['feedback'].runtimeType}');
    List<dynamic> imageJsonList = json['reportImage'];
    List<ReportImage> images = imageJsonList
        .map((imageJson) => ReportImage.fromJson(imageJson))
        .toList();
    return AttendanceReport(
      reportID: json['reportID'],
      topic: json['topic'],
      problem: json['problem'],
      message: json['message'],
      status: json['status'],
      createdAt: json['createdAt'] ?? '',
      isNew: json['new'],
      isImportant: json['important'],
      attendanceDetail:
          AttendanceDetailReport.fromJson(json['attendanceDetail']),
      feedback: json['feedback'] != null
          ? FeedbackDetail.fromJson(json['feedback'])
          : null,
      historyReports: List<HistoryReport>.from(
          json['historyReports'].map((x) => HistoryReport.fromJson(x))),
      reportImages: images,
    );
  }
}
