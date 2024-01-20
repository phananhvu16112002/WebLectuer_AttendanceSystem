import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/TestAttendanceDetail.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/CreateAttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/EditAttendanceDetail.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/FormPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/NotificationPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/ReportPage.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController searchController = TextEditingController();
  bool checkHome = true;
  bool checkNotification = false;
  bool checkReport = false;
  bool checkForm = false;
  bool checkAttendanceForm = false;
  bool checkEditAttendanceDetail = false;
  OverlayEntry? overlayEntry;
  TextEditingController searchInDashboardController = TextEditingController();

  // List<TestAttendanceDetail> attendanceDetailList = [

  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            Row(
              children: [leftHeader(), selectedPage()],
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
                    onTap: () {},
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

  Widget itemHeader(String title, Icon icon, bool check) {
    return InkWell(
      onTap: () {
        setState(() {
          checkHome = false;
          checkNotification = false;
          checkReport = false;
          checkForm = false;

          if (title == 'Home') {
            checkHome = true;
            checkAttendanceForm = false;
          } else if (title == 'Notifications') {
            checkNotification = true;
            checkAttendanceForm = false;
          } else if (title == 'Reports') {
            checkReport = true;
            checkAttendanceForm = false;
          } else if (title == 'Forms') {
            checkForm = true;
            checkAttendanceForm = false;
          } else {
            checkHome = true;
            checkAttendanceForm = false;
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
                backgroundColorButton: checkAttendanceForm
                    ? const Color.fromARGB(62, 226, 240, 253)
                    : Colors.transparent,
                borderColor: Colors.black,
                textColor: AppColors.textName,
                function: () {
                  setState(() {
                    checkHome = false;
                    checkNotification = false;
                    checkReport = false;
                    checkForm = false;
                    checkAttendanceForm = true;
                  });
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
            itemHeader('Forms', const Icon(Icons.edit_document), checkForm),
          ],
        ),
      ),
    );
  }

  Widget selectedPage() {
    if (checkHome) {
      return FormPage();
    } else if (checkNotification) {
      return const NotificationPage();
    } else if (checkReport) {
      return const ReportPage();
    } else if (checkForm) {
      return const FormPage();
    } else if (checkAttendanceForm) {
      return const CreateAttendanceFormPage();
    } else if (checkEditAttendanceDetail) {
      return const EditAttendanceDetail();
    } else {
      return FormPage();
    }
  }

  Container containerHome() {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const CustomText(
                message: 'Dashboard',
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryText),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 250,
              height: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customBoxInformation('All', 'assets/icons/student.png'),
                  customBoxInformation('Present', 'assets/icons/present.png'),
                  customBoxInformation('Absent', 'assets/icons/absent.png'),
                  customBoxInformation('Late', 'assets/icons/pending.png'),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 250,
              height: 40,
              child: Row(
                children: [
                  customButtonDashBoard('Export'),
                  customButtonDashBoard('PDF'),
                  customButtonDashBoard('Excel'),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 450,
                    height: 40,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2))
                        ],
                        border: Border.all(
                            color: Colors.black.withOpacity(0.2), width: 0.5),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      readOnly: false,
                      controller: searchInDashboardController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.normal,
                          fontSize: 15),
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          hintText: 'Search Student',
                          hintStyle: const TextStyle(
                              fontSize: 12, color: Color.fromARGB(73, 0, 0, 0)),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.transparent)),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.primaryButton),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  customWeek('Previous'),
                  customWeek('Week 8'),
                  customWeek('Next'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 250,
              height: 380,
              child: SingleChildScrollView(
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1), // Adjust the values as needed
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(3),
                    3: FlexColumnWidth(2),
                    4: FlexColumnWidth(2),
                    5: FlexColumnWidth(1),
                    6: FlexColumnWidth(2),
                    7: FlexColumnWidth(3),
                  },
                  border: TableBorder.all(color: AppColors.secondaryText),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: const Color(0xff1770f0).withOpacity(0.21),
                            child: const Center(
                              child: CustomText(
                                  message: 'STT',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color: const Color(0xff1770f0).withOpacity(0.21),
                            padding: const EdgeInsets.all(5),
                            child: const Center(
                              child: CustomText(
                                  message: 'StudentID',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: const Color(0xff1770f0).withOpacity(0.21),
                            child: const Center(
                              child: CustomText(
                                  message: 'Name',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: const Color(0xff1770f0).withOpacity(0.21),
                            child: const Center(
                              child: CustomText(
                                  message: 'Status',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: const Color(0xff1770f0).withOpacity(0.21),
                            child: const Center(
                              child: CustomText(
                                  message: 'Time',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: const Color(0xff1770f0).withOpacity(0.21),
                            child: Center(
                              child: CustomText(
                                  message: 'Edit',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: const Color(0xff1770f0).withOpacity(0.21),
                            child: const Center(
                              child: CustomText(
                                  message: 'Note',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (var data in TestAttendanceDetail.getData())
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.white,
                              child: Center(
                                child: CustomText(
                                    message: '${data.number}',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                child: CustomText(
                                    message: data.studentID,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.white,
                              child: Center(
                                child: CustomText(
                                    message: data.nameStudent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              color: chooseColor(data.status),
                              child: Center(
                                child: CustomText(
                                    message: data.status,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.white,
                              child: Center(
                                child: CustomText(
                                    message: data.timeAttendance,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.white,
                              child: Center(
                                child: InkWell(
                                  mouseCursor: SystemMouseCursors.click,
                                  onTap: () {
                                    setState(() {
                                      checkHome = false;
                                      checkNotification = false;
                                      checkReport = false;
                                      checkForm = false;
                                      checkAttendanceForm = false;
                                      checkEditAttendanceDetail = true;
                                    });
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (builder) =>
                                    //             EditAttendanceDetail()));
                                  },
                                  child: Text('Edit',
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryButton,
                                          decorationColor:
                                              AppColors.primaryButton,
                                          decoration:
                                              TextDecoration.underline)),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.white,
                              child: Center(
                                child: CustomText(
                                    message: data.note,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget customButtonDashBoard(String nameButton) {
  return InkWell(
    onTap: () {},
    mouseCursor: SystemMouseCursors.click,
    child: Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
          color:
              nameButton == 'Export' ? const Color(0xff2d71b1) : Colors.white,
          border: Border.all(
            width: 0.5,
            color: Colors.black.withOpacity(0.2),
          )),
      child: Center(
        child: CustomText(
            message: nameButton,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color:
                nameButton == 'Export' ? Colors.white : AppColors.primaryText),
      ),
    ),
  );
}

Widget customWeek(String nameButton) {
  return InkWell(
    onTap: () {},
    mouseCursor: SystemMouseCursors.click,
    child: Container(
      width: 80,
      height: 35,
      decoration: BoxDecoration(
          color: nameButton.contains('Week')
              ? const Color(0xff2d71b1)
              : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            width: 0.5,
            color: Colors.black.withOpacity(0.2),
          )),
      child: Center(
        child: CustomText(
            message: nameButton,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: nameButton.contains('Week')
                ? Colors.white
                : AppColors.primaryText),
      ),
    ),
  );
}

Widget customBoxInformation(String title, String imagePath) {
  return InkWell(
    onTap: () {},
    mouseCursor: SystemMouseCursors.click,
    child: Container(
      width: 200,
      height: 90,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
                color: AppColors.secondaryText,
                blurRadius: 2,
                offset: Offset(0, 2))
          ]),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    message: title,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorInformation),
                const CustomText(
                    message: '0',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorNumberInformation),
                const CustomText(
                    message: 'Student',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText)
              ],
            ),
            Image.asset(
              imagePath,
              width: 60,
              height: 60,
            )
          ],
        ),
      ),
    ),
  );
}

Color chooseColor(String status) {
  if (status == 'Present' || status.contains('Present')) {
    return Colors.green;
  } else if ((status == 'Absent' || status.contains('Absent'))) {
    return AppColors.importantText;
  } else if ((status == 'Late' || status.contains('Late'))) {
    return const Color.fromARGB(245, 237, 167, 81);
  }
  return AppColors.importantText;
}
