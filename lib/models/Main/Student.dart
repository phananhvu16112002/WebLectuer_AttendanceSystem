class Student {
  String studentID;
  String studentName;
  String studentEmail;
  String password;
  String hashedOTP;
  String accessToken;
  String refreshToken;
  bool active;
  double latitude;
  double longtitude;
  String location;

  Student(
      {required this.studentID,
      required this.studentName,
      required this.studentEmail,
      required this.password,
      required this.hashedOTP,
      required this.accessToken,
      required this.refreshToken,
      required this.active,
      required this.latitude,
      required this.longtitude,
      required this.location});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentID: json['studentID'] ?? '',
      studentName: json['studentName'] ?? '',
      studentEmail: json['studentEmail'] ?? '',
      password: json['password'] ?? '',
      hashedOTP: json['hashedOTP'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      active: json['active'] ?? false,
      latitude: json['latitude'] ?? 0.0,
      longtitude: json['longitude'] ?? 0.0,
      location: json['location'] ?? '',
    );
  }
}
