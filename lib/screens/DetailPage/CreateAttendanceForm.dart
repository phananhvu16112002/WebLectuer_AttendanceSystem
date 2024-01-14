import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/FormPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/NotificationPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/ReportPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/GetLocation.dart';

class CreateAttendanceFormPage extends StatefulWidget {
  const CreateAttendanceFormPage({super.key});

  @override
  State<CreateAttendanceFormPage> createState() =>
      _CreateAttendanceFormPageState();
}

class _CreateAttendanceFormPageState extends State<CreateAttendanceFormPage> {
  TextEditingController searchController = TextEditingController();
  bool checkHome = true;
  bool checkNotification = false;
  bool checkReport = false;
  bool checkForm = false;
  bool checkAttendaceForm = false;
  OverlayEntry? overlayEntry;
  TextEditingController classController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  bool checkPushNotification = false;
  double radius = 0;
  LatLng? _currentLocation;
  String myLocation = '';
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  DateTime date = DateTime.now();
  TimeOfDay? timeStart;
  TimeOfDay? timeEnd;

  void getLocation() async {
    Position position = await GetLocation().determinePosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      print('Latitude: ${position.latitude}');
      print('Longtitude: ${position.longitude}');
    });
  }

  Future<String?> getMyAddress() async {
    Position position = await GetLocation().determinePosition();
    var address = await GetLocation().getAddressFromLatLong(position);
    return address;
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
        print('TimeStart: ${formatTimeOfDate(timeStart!)}');
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

        print('TimeEnd: ${formatTimeOfDate(timeEnd!)}');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getMyAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _currentLocation != null
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  Row(
                    children: [leftHeader(), selectedPage()],
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: AppColors.colorHeader,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  mouseCursor: SystemMouseCursors.click,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 180),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      size: 25,
                      color: AppColors.textName,
                    ))
              ],
            ),
            Row(
              children: [
                CustomTextField(
                    controller: searchController,
                    textInputType: TextInputType.text,
                    obscureText: false,
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
                    hintText: 'Search',
                    prefixIcon: const Icon(null),
                    readOnly: false),
                const SizedBox(
                  width: 60,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_outlined)),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.messenger_outline_sharp)),
                const SizedBox(
                  width: 10,
                ),
                MouseRegion(
                  onHover: (event) => showMenu(
                    color: Colors.white,
                    context: context,
                    position: const RelativeRect.fromLTRB(300, 50, 30, 100),
                    items: [
                      const PopupMenuItem(
                        child: Text("My Profile"),
                      ),
                      const PopupMenuItem(
                        child: Text("Log Out"),
                      ),
                    ],
                  ),
                  child: Container(
                    child: const Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                            message: 'Anh Vu',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textName)
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget itemHeader(String title, Icon icon, bool check) {
    return InkWell(
      onTap: () {
        setState(() {
          checkHome = false;
          checkNotification = false;
          checkReport = false;
          checkForm = false;
          checkAttendaceForm = false;

          if (title == 'Home') {
            checkHome = true;
          } else if (title == 'Notifications') {
            checkNotification = true;
          } else if (title == 'Reports') {
            checkReport = true;
          } else if (title == 'Forms') {
            checkForm = true;
          } else if (title == 'AttendanceForm') {
            checkAttendaceForm = true;
          }
        });
      },
      child: Container(
        height: 40,
        width: 220,
        decoration: BoxDecoration(
            color: check
                ? const Color.fromARGB(62, 226, 240, 253)
                : Colors.transparent,
            border: Border.all(color: Colors.transparent, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              icon,
              const SizedBox(
                width: 5,
              ),
              CustomText(
                  message: title,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textName)
            ],
          ),
        ),
      ),
    );
  }

  Widget leftHeader() {
    return Container(
      width: 250,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const CustomText(
                message: 'Class Detail',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: CustomButton(
                buttonName: 'Create Form Attendance',
                backgroundColorButton: Colors.transparent,
                borderColor: Colors.black,
                textColor: AppColors.textName,
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) =>
                              const CreateAttendanceFormPage()));
                },
                height: 40,
                width: 200,
                fontSize: 12,
                colorShadow: Colors.transparent,
                borderRadius: 5,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const CustomText(
                message: 'Analyze',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryText),
            itemHeader('Dashboard', const Icon(Icons.home_outlined), checkHome),
            const CustomText(
                message: 'Manage',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryText),
            itemHeader('Notifications',
                const Icon(Icons.notifications_outlined), checkNotification),
            itemHeader('Reports', const Icon(Icons.book_outlined), checkReport),
            itemHeader(
                'Forms', const Icon(Icons.edit_document), checkAttendaceForm),
          ],
        ),
      ),
    );
  }

  Widget selectedPage() {
    if (checkHome) {
      return containerHome();
    } else if (checkNotification) {
      return const NotificationPage();
    } else if (checkReport) {
      return const ReportPage();
    } else if (checkForm) {
      return const FormPage();
    } else if (checkAttendaceForm) {
      return const CreateAttendanceFormPage();
    } else {
      return containerHome();
    }
  }

  Container containerHome() {
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
              Container(
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
                          classController,
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
                      customTextField(
                          560,
                          40,
                          true,
                          classController,
                          TextInputType.none,
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.expand_more)),
                          'Scan your face',
                          false),
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
                          classController,
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
                                  color:
                                      AppColors.primaryText.withOpacity(0.7)),
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
                                      icon: const Icon(
                                          Icons.watch_later_outlined)),
                                  timeStart != null
                                      ? formatTime(formatTimeOfDate(timeStart!)
                                          .toString())
                                      : formatTime(
                                          formatTimeOfDate(TimeOfDay.now())
                                              .toString()),
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
                                  color:
                                      AppColors.primaryText.withOpacity(0.7)),
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
                                      icon: const Icon(
                                          Icons.watch_later_outlined)),
                                  timeEnd != null
                                      ? formatTime(
                                          formatTimeOfDate(timeEnd!).toString())
                                      : formatTime(
                                          formatTimeOfDate(TimeOfDay.now())
                                              .toString()),
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
                            function: () {},
                            height: 50,
                            width: 350,
                            fontSize: 20,
                            colorShadow: Colors.white,
                            borderRadius: 10),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  width: (MediaQuery.of(context).size.width - 250) / 2 - 10,
                  height: 550,
                  child: GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _currentLocation!, zoom: 18),
                    markers: {
                      Marker(
                        icon: BitmapDescriptor.defaultMarker,
                        markerId: const MarkerId('currentLocation'),
                        position: _currentLocation!,
                        draggable: true,
                        infoWindow: const InfoWindow(title: 'Your Location'),
                      ),
                    },
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: true,
                    mapToolbarEnabled: true,
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
                  ))
            ],
          )),
    );
  }

  Widget customTextField(
      double width,
      double height,
      bool readOnly,
      TextEditingController controller,
      TextInputType textInputType,
      IconButton iconSuffix,
      String labelText,
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
            labelText: labelText,
            labelStyle:
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
