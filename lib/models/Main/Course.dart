class Course {
   String? courseID;
   String? courseName;
   int? totalWeeks;
   int? Weeks;
   int? credit;

  Course({
     this.courseID,
     this.courseName,
     this.totalWeeks,
     this.Weeks,
     this.credit,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        courseID: json['courseID'] ?? "",
        courseName: json['courseName'] ?? "",
        totalWeeks: json['totalWeeks'] ?? 0,
        Weeks: json['Weeks'] ?? 0,
        credit: json['credit'] ?? 0);
  }
}
