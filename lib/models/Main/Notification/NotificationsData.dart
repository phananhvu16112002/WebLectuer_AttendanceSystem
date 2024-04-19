import 'package:weblectuer_attendancesystem_nodejs/models/Main/Notification/ReportNotifications.dart';

class NotificationsData {
   List<ReportNotifications>? importantNews;
   List<ReportNotifications>? latestNews;
   int? total;
   int? totalNew;
   int? totalOld;

  NotificationsData({
     this.importantNews ,
     this.latestNews,
     this.total = 0,
     this.totalNew = 0,
     this.totalOld = 0,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) {
    List<ReportNotifications> importantNews = (json['importantNews'] as List)
        .map((reportJson) => ReportNotifications.fromJson(reportJson))
        .toList();

    List<ReportNotifications> latestNews = (json['lastestNews'] as List)
        .map((reportJson) => ReportNotifications.fromJson(reportJson))
        .toList();

    return NotificationsData(
      importantNews: importantNews,
      latestNews: latestNews,
      total: int.parse(json['stats']['total']),
      totalNew: int.parse(json['stats']['totalNew']),
      totalOld: int.parse(json['stats']['totalOld']),
    );
  }
}
