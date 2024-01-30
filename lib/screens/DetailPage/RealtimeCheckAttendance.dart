import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/TestAttendanceDetail.dart';

//After create attendance form --> RealtimeCheckAttendance.
class RealtimeCheckAttendance extends StatefulWidget {
  const RealtimeCheckAttendance({super.key});

  @override
  State<RealtimeCheckAttendance> createState() =>
      _RealtimeCheckAttendanceState();
}

class _RealtimeCheckAttendanceState extends State<RealtimeCheckAttendance> {
  TextEditingController searchInDashboardController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                            child: const Center(
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
                                    setState(() {});
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
