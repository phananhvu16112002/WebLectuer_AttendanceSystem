class AttendanceStats {
  final String formID;
  final String startTime;
  final String endTime;
  final int status;
  final String dateOpen;
  final int type;
  final double latitude;
  final double longitude;
  final double radius;
  final String classID;
  final int total;
  final int totalPresence;
  final int totalAbsence;
  final int totalLate;

  AttendanceStats({
    required this.formID,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.dateOpen,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.classID,
    required this.total,
    required this.totalPresence,
    required this.totalAbsence,
    required this.totalLate,
  });

  factory AttendanceStats.fromJson(Map<String, dynamic> json) {
    // print(json['latitude'].runtimeType);
    // print(json['longitude'].runtimeType);
    // print(json['radius'].runtimeType);

    return AttendanceStats(
      formID: json['formID'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
      dateOpen: json['dateOpen'] ?? '',
      type: json['type'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      radius: double.parse(json['radius'].toString()),
      classID: json['classID'],
      total: int.parse(json['total']),
      totalPresence: int.parse(json['totalPresence']),
      totalAbsence: int.parse(json['totalAbsence']),
      totalLate: int.parse(json['totalLate']),
    );
  }
}
