import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:gif_view/gif_view.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/HomePage.dart';

class AfterCreateAttendanceForm extends StatefulWidget {
  const AfterCreateAttendanceForm({super.key, required this.attendanceForm});
  final AttendanceForm? attendanceForm;

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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width:
                            (MediaQuery.of(context).size.width - 250) / 2 - 20,
                        height: qrcode.isNotEmpty ? 630 : 500,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                      message: 'Class:',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryText),
                                  CustomText(
                                      message: 'Cross Platform Programming',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryText
                                          .withOpacity(0.5))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                      message: 'Type:',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryText),
                                  CustomText(
                                      message: 'Scan face',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryText
                                          .withOpacity(0.5))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                      message: 'Date:',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryText),
                                  CustomText(
                                      message: '18/01/2024',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryText
                                          .withOpacity(0.5))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                      message: 'StartTime:',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryText),
                                  CustomText(
                                      message: '12:30 PM',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryText
                                          .withOpacity(0.5))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                      message: 'EndTime:',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryText),
                                  CustomText(
                                      message: '14:17 PM',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryText
                                          .withOpacity(0.5))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                      message: 'Duration:',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryText),
                                  CustomText(
                                      message: '',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryText
                                          .withOpacity(0.5))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                      message: 'Distance:',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryText),
                                  CustomText(
                                      message: '10M',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryText
                                          .withOpacity(0.5))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                      message: 'QR Code:',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryText),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  if (qrcode.isNotEmpty)
                                    InkWell(
                                      mouseCursor: SystemMouseCursors.zoomIn,
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                  child: Container(
                                                height: 300,
                                                width: 300,
                                                child: Center(
                                                  child: QrImageView(
                                                    version: 10,
                                                    data: qrcode,
                                                    size: 250,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    embeddedImage: const AssetImage(
                                                        'assets/images/logo.png'),
                                                    eyeStyle: const QrEyeStyle(
                                                        eyeShape:
                                                            QrEyeShape.square,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ));
                                            });
                                      },
                                      child: QrImageView(
                                        version: 10,
                                        data: qrcode,
                                        size: 150,
                                        padding: const EdgeInsets.all(0),
                                        embeddedImage: const AssetImage(
                                            'assets/images/logo.png'),
                                        eyeStyle: const QrEyeStyle(
                                            eyeShape: QrEyeShape.square,
                                            color: Colors.black),
                                      ),
                                    )
                                  else
                                    Container()
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
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => HomePage()),
                                          (route) => false);
                                    },
                                    height: 40,
                                    width: 300,
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
                                    function: () {},
                                    height: 40,
                                    width: 300,
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
            )
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
            Container(
              width: MediaQuery.of(context).size.width / 5,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (builder) => HomePage()));
                    },
                    mouseCursor: SystemMouseCursors.click,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        size: 25,
                        color: AppColors.textName,
                      ))
                ],
              ),
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
}
