import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/attendanceForm_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/socketServer_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/AfterCreateAttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/GetLocation.dart';

class CreateAttendanceFormPage extends StatefulWidget {
  const CreateAttendanceFormPage({super.key});

  @override
  State<CreateAttendanceFormPage> createState() =>
      _CreateAttendanceFormPageState();
}

class _CreateAttendanceFormPageState extends State<CreateAttendanceFormPage> {
  TextEditingController searchController = TextEditingController();
  OverlayEntry? overlayEntry;
  TextEditingController typeAttendanceController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  bool checkPushNotification = false;
  bool formCreated = false;
  double radius = 0;
  LatLng? _currentLocation;
  String myLocation = '';
  double latitude = 0;
  double longtitude = 0;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  DateTime date = DateTime.now();
  TimeOfDay? timeStart;
  TimeOfDay? timeEnd;
  var items = [
    'Scan face',
    'Check in class',
  ];
  String dropdownvalue = 'Scan face';
  int selectedIndex = 0;
  bool isStartTimeSelected = false;
  bool isEndTimeSelected = false;

  void getLocation() async {
    Position position = await GetLocation().determinePosition();
    String? tempAddress = await GetLocation().getAddressFromLatLong(position);

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      myLocation = tempAddress!;
      latitude = position.latitude;
      longtitude = position.longitude;
      print('Latitude: ${position.latitude}');
      print('Longtitude: ${position.longitude}');
      print('Address:$myLocation');
    });
  }

  Future<void> selectTimeStart(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
        barrierColor: Colors.black.withOpacity(0.2),
        helpText: 'Select Start Time For Attendance',
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              dialogBackgroundColor: AppColors.primaryButton,
            ),
            child: child!,
          );
        },
        context: context,
        initialTime: timeStart ?? TimeOfDay.now());
    if (time != null && time != timeStart) {
      setState(() {
        timeStart = time;
        isStartTimeSelected = true;
        print('TimeStart: ${formatTimeOfDate(timeStart!)}');
        checkDuplicateTime();
      });
    }
  }

  Future<void> selectTimeEnd(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
        barrierColor: Colors.black.withOpacity(0.2),
        helpText: 'Select Start Time For Attendance',
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              dialogBackgroundColor: AppColors.primaryButton,
            ),
            child: child!,
          );
        },
        context: context,
        initialTime: timeEnd ?? TimeOfDay.now());
    if (time != null && time != timeEnd) {
      setState(() {
        timeEnd = time;
        isEndTimeSelected = true;
        print('TimeEnd: ${formatTimeOfDate(timeEnd!)}');
        checkDuplicateTime();
      });
    }
  }

  bool checkDuplicateTime() {
    if (isStartTimeSelected && isEndTimeSelected) {
      if (timeStart!.hour > timeEnd!.hour ||
          (timeStart!.hour == timeEnd!.hour &&
              timeStart!.minute >= timeEnd!.minute)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Error'),
              content: const Text('Start Time must be before End Time.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      var socketServerProvider =
          Provider.of<SocketServerProvider>(context, listen: false);
      socketServerProvider.connectToSocketServer('5202111_09_t000');
    });
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceFormDataProvider =
        Provider.of<AttendanceFormDataProvider>(context, listen: false);
    final socketServerProvider =
        Provider.of<SocketServerProvider>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoForm(
                  context, attendanceFormDataProvider, socketServerProvider),
              googleMaps(context)
            ],
          )),
    );
  }

  Widget infoForm(
      BuildContext context,
      AttendanceFormDataProvider attendanceFormDataProvider,
      SocketServerProvider socketServerProvider) {
    return Container(
      width: (MediaQuery.of(context).size.width - 250) / 2 - 20,
      height: 550,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CustomText(
                  message: 'Attendance Form',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryButton),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomText(
                message: 'Class',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryText.withOpacity(0.7)),
            const SizedBox(
              height: 5,
            ),
            customTextField(
                560,
                40,
                true,
                typeAttendanceController,
                TextInputType.none,
                IconButton(onPressed: () {}, icon: const Icon(null)),
                'Cross-platform Programming,Tuesday ,Shift: 3, Room: A0401',
                false),
            const SizedBox(
              height: 5,
            ),
            CustomText(
                message: 'Type',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryText.withOpacity(0.7)),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 560,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    width: 1, color: AppColors.primaryText.withOpacity(0.2)),
              ),
              child: DropdownButton(
                underline: Container(),
                value: dropdownvalue,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.primaryText.withOpacity(0.5),
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(
                      value: items,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 380,
                          child: Text(
                            items,
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryText.withOpacity(0.5),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedIndex = items.indexOf(newValue!);
                    dropdownvalue = newValue;
                  });
                  print("Selected index: $selectedIndex");
                },
              ),
            ),
            const SizedBox(height: 5),
            CustomText(
                message: 'Date',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryText.withOpacity(0.7)),
            const SizedBox(height: 5),
            customTextField(
                560,
                40,
                true,
                typeAttendanceController,
                TextInputType.none,
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_month_rounded)),
                formatDate(date.toString()),
                false),
            const SizedBox(height: 5),
            CustomText(
                message: 'Distance: ${radius.ceil()}m',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryText.withOpacity(0.7)),
            const SizedBox(height: 5),
            Slider(
                thumbColor: AppColors.primaryButton.withOpacity(0.5),
                activeColor: AppColors.primaryButton.withOpacity(0.2),
                label: 'Distance',
                value: radius,
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    radius = value;
                  });
                }),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        message: "Start Time ",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryText.withOpacity(0.7)),
                    const SizedBox(
                      height: 5,
                    ),
                    customTextField(
                        150,
                        40,
                        true,
                        startTimeController,
                        TextInputType.datetime,
                        IconButton(
                            onPressed: () => selectTimeStart(context),
                            icon: const Icon(Icons.watch_later_outlined)),
                        timeStart != null
                            ? formatTime(
                                formatTimeOfDate(timeStart!).toString())
                            : formatTime(
                                formatTimeOfDate(TimeOfDay.now()).toString()),
                        true),
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        message: "End Time ",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryText.withOpacity(0.7)),
                    const SizedBox(
                      height: 5,
                    ),
                    customTextField(
                        150,
                        40,
                        true,
                        startTimeController,
                        TextInputType.datetime,
                        IconButton(
                            onPressed: () => selectTimeEnd(context),
                            icon: const Icon(Icons.watch_later_outlined)),
                        timeEnd != null
                            ? formatTime(formatTimeOfDate(timeEnd!).toString())
                            : formatTime(
                                formatTimeOfDate(TimeOfDay.now()).toString()),
                        true),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                CustomText(
                    message: 'Push Notification to everyone',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryText.withOpacity(0.7)),
                const SizedBox(
                  width: 10,
                ),
                Switch(
                    activeColor: Colors.green,
                    activeTrackColor: Colors.black.withOpacity(0.05),
                    splashRadius: 10,
                    value: checkPushNotification,
                    onChanged: (value) {
                      setState(() {
                        checkPushNotification = value;
                      });
                    })
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: CustomButton(
                  buttonName: "Create",
                  backgroundColorButton: AppColors.primaryButton,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                  function: () async {
                    bool check = checkDuplicateTime();
                    if (check) {
                      print('Longtitude: $longtitude');
                      AttendanceForm? attendanceForm = await API()
                          .createFormAttendance(
                              '5202111_09_t000',
                              formatTimeOfDate(timeStart!).toString(),
                              formatTimeOfDate(timeEnd!).toString(),
                              selectedIndex,
                              myLocation,
                              latitude,
                              longtitude,
                              radius);
                      List<AttendanceForm> temp = [];
                      temp.add(attendanceForm!);

                      final currentContext = context;
                      Future.delayed(Duration.zero, () {
                        attendanceFormDataProvider.setAttendanceFormData(temp);
                        socketServerProvider.sendAttendanceForm(attendanceForm);
                      });
                      //QR View have properties data so add data from provider and display QR Code on screen
                      if (mounted) {
                        Navigator.pushReplacement(
                            currentContext,
                            MaterialPageRoute(
                                builder: (builder) => AfterCreateAttendanceForm(
                                      attendanceForm: attendanceForm,
                                    )));
                      }

                      print('Success');
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text('Error'),
                            content: const Text(
                                'Please check startTime and endTime'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  height: 50,
                  width: 350,
                  fontSize: 20,
                  colorShadow: Colors.white,
                  borderRadius: 10),
            )
          ],
        ),
      ),
    );
  }

  Widget googleMaps(BuildContext context) {
    if (_currentLocation != null) {
      return Container(
          width: (MediaQuery.of(context).size.width - 250) / 2 - 10,
          height: 550,
          child: GoogleMap(
            zoomGesturesEnabled: true,
            indoorViewEnabled: true,
            initialCameraPosition:
                CameraPosition(target: _currentLocation!, zoom: 18),
            markers: {
              Marker(
                icon: BitmapDescriptor.defaultMarker,
                markerId: const MarkerId('currentLocation'),
                position: _currentLocation!,
                infoWindow: const InfoWindow(title: 'My Location'),
              ),
            },
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: false,
            myLocationEnabled: true,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              googleMapController = controller;
            },
            circles: {
              Circle(
                  circleId: const CircleId('ID1'),
                  radius: radius,
                  fillColor: AppColors.primaryButton.withOpacity(0.2),
                  strokeColor: AppColors.primaryButton.withOpacity(0.1),
                  strokeWidth: 5,
                  center: _currentLocation!)
            },
          ));
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget customTextField(
      double width,
      double height,
      bool readOnly,
      TextEditingController controller,
      TextInputType textInputType,
      IconButton iconSuffix,
      String hintText,
      bool enabled) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.black.withOpacity(0.2)),
              left: BorderSide(color: Colors.black.withOpacity(0.2)),
              right: BorderSide(color: Colors.black.withOpacity(0.2)),
              bottom: BorderSide(color: Colors.black.withOpacity(0.2))),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: TextFormField(
        enabled: enabled,
        readOnly: readOnly,
        controller: controller,
        keyboardType: textInputType,
        style: const TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.normal,
            fontSize: 15),
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            suffixIcon: iconSuffix,
            hintText: hintText,
            hintStyle:
                TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(width: 1, color: Colors.transparent)),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1, color: AppColors.primaryButton),
            )),
      ),
    );
  }

  String formatDate(String date) {
    DateTime serverDateTime = DateTime.parse(date);
    String formattedDate = DateFormat('dd-MM-yyyy').format(serverDateTime);
    return formattedDate;
  }

  String formatTime(String time) {
    DateTime serverDateTime = DateTime.parse(time);
    String formattedTime = DateFormat('HH:mm a').format(serverDateTime);
    return formattedTime;
  }

  DateTime formatTimeOfDate(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }
}
