import 'package:weblectuer_attendancesystem_nodejs/models/AttendanceState.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/StudentClasses.dart';

class AttendanceModel {
  List<StudentClasses> data;
  AttendanceStats stats;

  AttendanceModel({
    required this.data,
    required this.stats,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      data: List<StudentClasses>.from(
          json['data'].map((x) => StudentClasses.fromJson(x))),
      stats: AttendanceStats.fromJson({
        'all': json['all'],
        'pass': json['pass'],
        'ban': json['ban'],
        'warning': json['warning'],
      }),
    );
  }
}
