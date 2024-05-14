class GroupBarChart {
  String? label;
  String? date;
  int? totalPresent;
  int? totalLate;
  int? totalAbsent;

  GroupBarChart({
    this.label,
    this.date,
    this.totalPresent,
    this.totalLate,
    this.totalAbsent,
  });

  factory GroupBarChart.fromJson(Map<String, dynamic> json) {
    return GroupBarChart(
      label: json['label'],
      date: json['date'],
      totalPresent: json['totalPresent'],
      totalLate: json['totalLate'],
      totalAbsent: json['totalAbsent'],
    );
  }
}
