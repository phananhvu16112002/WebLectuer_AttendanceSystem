class AttendanceStatus {
  int all;
  int pass;
  int ban;
  int warning;

  AttendanceStatus({
    required this.all,
    required this.pass,
    required this.ban,
    required this.warning,
  });

  factory AttendanceStatus.fromJson(Map<String, dynamic> json) {
    return AttendanceStatus(
      all: json['all'],
      pass: json['pass'],
      ban: json['ban'],
      warning: json['warning'],
    );
  }
}
