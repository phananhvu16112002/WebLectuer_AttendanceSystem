import 'package:weblectuer_attendancesystem_nodejs/models/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Course.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Teacher.dart';

class StudentClasses {
  String studentID;
  Class classes;

  StudentClasses({
    required this.studentID,
    required this.classes,
  });
  factory StudentClasses.fromJson(Map<String, dynamic> json) {
    print('StudentClasses.fromJson: $json');

    final dynamic classesJson = json['classDetail'];
    final Class classes = classesJson is String
        ? Class(
            classID: classesJson,
            roomNumber: "",
            shiftNumber: 0,
            startTime: "",
            endTime: "",
            classType: "",
            group: "",
            subGroup: "",
            teacher: Teacher(
                teacherID: "",
                teacherName: "",
                teacherHashedPassword: "",
                teacherEmail: "",
                teacherHashedOTP: "",
                timeToLiveOTP: "",
                accessToken: "",
                refreshToken: "",
                resetToken: "",
                active: false),
            course: Course(
                courseID: "",
                courseName: "",
                totalWeeks: 0,
                requiredWeeks: 0,
                credit: 0))
        : Class.fromJson(classesJson ?? {});
    return StudentClasses(
      studentID: json['studentDetail'] ?? "",
      classes: classes,
    );
  }
}
