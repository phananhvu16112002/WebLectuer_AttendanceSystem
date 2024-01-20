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
}
