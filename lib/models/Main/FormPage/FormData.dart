class FormData {
   String formID;
   String startTime;
   String endTime;
   bool status;
   String dateOpen;
   int type;
   double latitude;
   double longitude;
   int radius;

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
