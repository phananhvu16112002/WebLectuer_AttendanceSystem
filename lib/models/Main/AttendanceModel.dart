import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceState.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/StudentClasses.dart';

class AttendanceDetailResponseStudent {
  List<StudentClasses> data;
  AttendanceStatus stats;

  AttendanceDetailResponseStudent({
    required this.data,
    required this.stats,
  });

  factory AttendanceDetailResponseStudent.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailResponseStudent(
      data: List<StudentClasses>.from(
          json['data'].map((x) => StudentClasses.fromJson(x))),
      stats: AttendanceStatus.fromJson({
        'all': json['all'],
        'pass': json['pass'],
        'ban': json['ban'],
        'warning': json['warning'],
      }),
    );
  }
}
