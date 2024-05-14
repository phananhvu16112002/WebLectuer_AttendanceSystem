import 'package:weblectuer_attendancesystem_nodejs/models/Main/ChartPage/group_bar_chart.dart';

class ProgressModel {
  int? progressPass;
  int? progressWarning;
  int? progressBan;
  int? progressPresent;
  int? progressLate;
  int? progressAbsent;
  int? total;
  int? pass;
  int? ban;
  int? warning;
  List<GroupBarChart>? groupBarCharts;

  ProgressModel(
      {this.progressPass,
      this.progressWarning,
      this.progressBan,
      this.progressPresent,
      this.progressLate,
      this.progressAbsent,
      this.groupBarCharts,
      this.total,
      this.pass,
      this.ban,
      this.warning});

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    var groupBarChartsList = json['groupBarCharts'] as List;
    List<GroupBarChart> groupBarCharts =
        groupBarChartsList.map((item) => GroupBarChart.fromJson(item)).toList();

    return ProgressModel(
      progressPass: json['progressPass'],
      progressWarning: json['progressWarning'],
      progressBan: json['progressBan'],
      progressPresent: json['progressPresent'],
      progressLate: json['progressLate'],
      progressAbsent: json['progressAbsent'],
      total: json['total'],
      pass: json['pass'],
      ban: json['ban'],
      warning: json['warning'],
      groupBarCharts: groupBarCharts,
    );
  }
}
