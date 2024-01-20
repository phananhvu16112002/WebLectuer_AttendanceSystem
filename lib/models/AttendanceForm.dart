class AttendanceForm {
  String formID;
  String classes;
  String? startTime;
  String? endTime;
  String? dateOpen;
  bool status;
  int typeAttendance;
  String location;
  double latitude;
  double longtitude;
  double radius;

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

  factory AttendanceForm.fromJson(Map<String, dynamic> json) {
    print('AttendanceForm.fromJson: $json');
    return AttendanceForm(
        formID: json['formID'],
        classes: json['classes'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        dateOpen: json['dateOpen'],
        status: json['status'],
        typeAttendance: json['type'],
        location: json['location'],
        latitude: json['latitude'],
        longtitude: json['longtitude'],
        radius: json['radius']);
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
