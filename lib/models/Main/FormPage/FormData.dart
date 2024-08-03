class FormData {
   String? formID;
   String? startTime;
   String? endTime;
   bool status;
   String? dateOpen;
   int? type;
   double? latitude;
   double? longitude;
   int? radius;
   String? periodDateTime;

  FormData({
     this.formID,
     this.startTime,
     this.endTime,
     required this.status,
     this.dateOpen,
     this.type,
     this.latitude,
     this.longitude,
     this.radius,
     this.periodDateTime
  });

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      formID: json['formID'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
      dateOpen: json['dateOpen'],
      type: json['type'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      radius: json['radius'],
      periodDateTime: json['periodDateTime']
    );
  }
}
