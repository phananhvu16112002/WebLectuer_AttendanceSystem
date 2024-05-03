import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:gif_view/gif_view.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/socketServer_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/FormPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/RealtimeCheckAttendance.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/HomePage.dart';

class AfterCreateAttendanceForm extends StatefulWidget {
  const AfterCreateAttendanceForm(
      {super.key, required this.attendanceForm, required this.className});
  final AttendanceForm? attendanceForm;
  final String className;

  @override
  State<AfterCreateAttendanceForm> createState() =>
      _AfterCreateAttendanceFormState();
}

//Modify data from attendanceForm
class _AfterCreateAttendanceFormState extends State<AfterCreateAttendanceForm> {
  String qrcode = '';
  late AttendanceForm data;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    //Scan QR.
    super.initState();
    data = widget.attendanceForm!;
    var tempData = {
      "formID": data.formID,
      "classID": data.classes,
      "startTime": data.startTime,
      "endTime": data.endTime,
      "dateOpen": data.dateOpen,
      "typeAttendanced": data.typeAttendance
    };
    if (data.formID.isNotEmpty) {
      qrcode = jsonEncode(tempData);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('String QRCODE: $qrcode');
    final socketServerProvider =
        Provider.of<SocketServerProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: AppColors.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 250) / 2,
                          // height: qrcode.isNotEmpty ? 600 : 500,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  width: 0.5,
                                  color: Colors.black.withOpacity(0.2))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: GifView.asset(
                                    'assets/images/success.gif',
                                    color: Colors.white.withOpacity(0.5),
                                    colorBlendMode: BlendMode.overlay,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Center(
                                  child: CustomText(
                                      message:
                                          'Create Attendance Form Successfully',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryButton),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.05),
                                  thickness: 0.5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: const CustomText(
                                          message: 'Class:',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryText),
                                    ),
                                    Expanded(
                                        child: Text(
                                      widget.className,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryText
                                            .withOpacity(0.5),
                                      ),
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: const CustomText(
                                          message: 'Type:',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryText),
                                    ),
                                    Expanded(
                                      child: Text(
                                        textAlign: TextAlign.end,
                                        getType(data.typeAttendance),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryText
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: const CustomText(
                                          message: 'Date:',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryText),
                                    ),
                                    Expanded(
                                      child: Text(
                                        textAlign: TextAlign.end,
                                        formatDate(data.dateOpen ??
                                            DateTime.now().toString()),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryText
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: const CustomText(
                                          message: 'StartTime:',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryText),
                                    ),
                                    Expanded(
                                      child: Text(
                                        textAlign: TextAlign.end,
                                        formatTime(data.startTime ??
                                            DateTime.now().toString()),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryText
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: const CustomText(
                                          message: 'EndTime:',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryText),
                                    ),
                                    Expanded(
                                      child: Text(
                                        textAlign: TextAlign.end,
                                        formatTime(data.endTime ??
                                            DateTime.now().toString()),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryText
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: const CustomText(
                                          message: 'Distance:',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryText),
                                    ),
                                    Expanded(
                                      child: Text(
                                        textAlign: TextAlign.end,
                                        data.radius.toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryText
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (qrcode.isNotEmpty)
                                      Align(
                                        child: InkWell(
                                          mouseCursor:
                                              SystemMouseCursors.zoomIn,
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                      child: SizedBox(
                                                    height: 300,
                                                    width: 300,
                                                    child: Center(
                                                      child: QrImageView(
                                                        version: 10,
                                                        data: qrcode,
                                                        size: 250,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        embeddedImage:
                                                            const AssetImage(
                                                                'assets/images/logo.png'),
                                                        eyeStyle:
                                                            const QrEyeStyle(
                                                                eyeShape:
                                                                    QrEyeShape
                                                                        .square,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                  ));
                                                });
                                          },
                                          child: QrImageView(
                                            version: 10,
                                            data: qrcode,
                                            size: 180,
                                            padding: const EdgeInsets.all(0),
                                            embeddedImage: const AssetImage(
                                                'assets/images/logo.png'),
                                            eyeStyle: const QrEyeStyle(
                                                eyeShape: QrEyeShape.square,
                                                color: Colors.black),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: CustomButton(
                                      buttonName: 'Back to home',
                                      backgroundColorButton: Colors.white,
                                      borderColor: AppColors.primaryButton,
                                      textColor: AppColors.primaryButton,
                                      function: () {
                                        socketServerProvider
                                            .disconnectSocketServer();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    const HomePage()),
                                            (route) => false);
                                      },
                                      height: 40,
                                      width: 290,
                                      fontSize: 15,
                                      colorShadow: Colors.transparent,
                                      borderRadius: 10),
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: CustomButton(
                                      buttonName: 'View Attendance',
                                      backgroundColorButton:
                                          AppColors.primaryButton,
                                      borderColor: Colors.transparent,
                                      textColor: Colors.white,
                                      function: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    RealtimeCheckAttendance(
                                                      formID: widget
                                                          .attendanceForm!
                                                          .formID,
                                                      classes: widget
                                                          .attendanceForm!
                                                          .classes,
                                                    )));
                                      },
                                      height: 40,
                                      width: 290,
                                      fontSize: 15,
                                      colorShadow: Colors.transparent,
                                      borderRadius: 10),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
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
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const HomePage()));
                    },
                    mouseCursor: SystemMouseCursors.click,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
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
                  // onEnter: (event) => _showPopupMenu(context),
                  // onExit: (event) => _removePopupMenu(),
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

  String formatDate(String date) {
    if (date != '') {
      DateTime serverDateTime = DateTime.parse(date).toLocal();
      String formattedDate = DateFormat('MMMM d, y').format(serverDateTime);
      return formattedDate;
    }
    return '';
  }

  String formatTime(String time) {
    DateTime serverDateTime = DateTime.parse(time).toLocal();
    String formattedTime = DateFormat("HH:mm:ss a").format(serverDateTime);
    return formattedTime;
  }

  String getType(int result) {
    if (result == 0) {
      return 'Scan Face';
    } else if (result == 1) {
      return 'Check in class';
    } else {
      return 'Scan QR';
    }
  }
}
