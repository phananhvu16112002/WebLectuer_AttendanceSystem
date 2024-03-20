class FormData {
  final String formID;
  final String startTime;
  final String endTime;
  final bool status;
  final String dateOpen;
  final int type;
  final double latitude;
  final double longitude;
  final int radius;

  FormData({
    required this.formID,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.dateOpen,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      formID: json['formID'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
      dateOpen: json['dateOpen'] ?? '',
      type: json['type'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      radius: json['radius'],
    );
  }
}
