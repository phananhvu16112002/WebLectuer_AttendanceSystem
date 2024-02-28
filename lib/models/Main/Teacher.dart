class Teacher {
  final String teacherID;
  final String teacherName;
  final String teacherHashedPassword;
  final String teacherEmail;
  final String teacherHashedOTP;
  final String timeToLiveOTP;
  final String accessToken;
  final String refreshToken;
  final String resetToken;
  final bool active;

  Teacher({
    required this.teacherID,
    required this.teacherName,
    required this.teacherHashedPassword,
    required this.teacherEmail,
    required this.teacherHashedOTP,
    required this.timeToLiveOTP,
    required this.accessToken,
    required this.refreshToken,
    required this.resetToken,
    required this.active,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
        teacherID: json['teacherID'] ?? '',
        teacherName: json['teacherName'] ?? "",
        teacherHashedPassword: json['teacherHashedPassword'] ?? "",
        teacherEmail: json['teacherEmail'] ?? "",
        teacherHashedOTP: json['teacherHashedOTP'] ?? "",
        timeToLiveOTP: json["timeToLiveOTP"] ?? "",
        accessToken: json['accessToken'] ?? "",
        refreshToken: json['refreshToken'] ?? "",
        resetToken: json['resetToken'] ?? "",
        active: json['active'] ?? false);
  }
}
