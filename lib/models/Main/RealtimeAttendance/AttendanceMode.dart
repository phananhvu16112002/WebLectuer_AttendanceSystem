import 'package:weblectuer_attendancesystem_nodejs/models/Main/RealtimeAttendance/AttendanceData.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/RealtimeAttendance/AttendanceStats.dart';

class AttendanceModel {
  final List<AttendanceData> data;
  final AttendanceStats stats;

  AttendanceModel({required this.data, required this.stats});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataList = json['data'];
    List<AttendanceData> data = dataList.map((item) => AttendanceData.fromJson(item)).toList();
    AttendanceStats stats = AttendanceStats.fromJson(json['stats']);
    return AttendanceModel(data: data, stats: stats);
  }
}