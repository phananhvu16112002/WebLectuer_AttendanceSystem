class AttendanceForm {
  final String formID;
  final String classes;
  final String? startTime;
  final String? endTime;
  final String? dateOpen;
  final bool status;
  final int typeAttendance;
  final String location;
  final double latitude;
  final double longtitude;
  final double radius;

  AttendanceForm({
    required this.formID,
    required this.classes,
    required this.startTime,
    required this.endTime,
    required this.dateOpen,
    required this.status,
    required this.typeAttendance,
    required this.location,
    required this.latitude,
    required this.longtitude,
    required this.radius,
  });

  String toString() {
    return 'FormID: ${formID}, Classes: $classes, startTime: $startTime, endTime: $endTime, dateOpen: $dateOpen, status: $status, typeAttendance: $typeAttendance, location: $location, latitude: $latitude, longitude: $longtitude, radius: $radius';
  }

  factory AttendanceForm.fromJson(Map<String, dynamic> json) {
    print('AttendanceForm.fromJson: $json');
    return AttendanceForm(
        formID: json['formID'] ?? '',
        classes: json['classes'] ?? '',
        startTime: json['startTime'] ?? '',
        endTime: json['endTime'] ?? '',
        dateOpen: json['dateOpen'] ?? '',
        status: json['status'] ?? false,
        typeAttendance: json['type'] ?? 0,
        location: json['location'] ?? '',
        latitude: json['latitude'] ?? 0.0,
        longtitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
        radius: json['radius'] ?? 0.0);
  }

  static List<AttendanceForm> getData() {
    return [
      AttendanceForm(
          formID: 'FormID14',
          classes: '520H3333333',
          startTime: '12:30 PM',
          endTime: '15:30 PM',
          dateOpen: '17/01/2024',
          status: true,
          typeAttendance: 0,
          location: '19 Nguyen Huu Tho, District 7, HCMC',
          latitude: 10.0000002,
          longtitude: 10.0000002,
          radius: 50),
      AttendanceForm(
          formID: 'FormID13',
          classes: '520H3333333ádsad',
          startTime: '12:30 PM',
          endTime: '15:30 PM',
          dateOpen: '17/01/2024',
          status: true,
          typeAttendance: 0,
          location: '19 Nguyen Huu Tho, District 7, HCMC',
          latitude: 10.0000002,
          longtitude: 10.0000002,
          radius: 50),
      AttendanceForm(
          formID: 'FormID12',
          classes: '520H3333333123asd',
          startTime: '12:30 PM',
          endTime: '15:30 PM',
          dateOpen: '17/01/2024',
          status: true,
          typeAttendance: 1,
          location: '19 Nguyen Huu Tho, District 7, HCMC',
          latitude: 10.0000002,
          longtitude: 10.0000002,
          radius: 50)
    ];
  }
}
