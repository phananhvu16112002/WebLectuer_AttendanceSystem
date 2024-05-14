import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/ReportData.dart';

class ReportPaginations {
  int? totalPage;
  List<ReportData>? reports;

  ReportPaginations({
    this.totalPage,
    this.reports,
  });

  factory ReportPaginations.fromJson(Map<String, dynamic> map) {
    return ReportPaginations(
      totalPage: map['totalPage'] as int?,
      reports: (map['reports'] as List<dynamic>)
          .map((x) => ReportData.fromJson(x as Map<String, dynamic>))
          .toList(),
    );
  }
}
