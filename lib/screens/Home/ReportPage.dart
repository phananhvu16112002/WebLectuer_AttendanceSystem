import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomRichText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/AttendanceReport.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/DialogHistoryReport/HistoryReportDialog.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/HistoryReport.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/ReportData.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/FormPage.dart';

import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String text =
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sit maiores, perferendis suscipit veniam ratione fuga cumque incidunt quam deleniti vitae maxime totam omnis quidem quo consectetur ad? Veniam, harum? Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sit maiores, perferendis suscipit veniam ratione fuga cumque incidunt quam deleniti vitae maxime totam omnis quidem quo consectetur ad? Veniam, harum? Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sit m';
  String? selectedValue;
  String newSelectedValue = 'Present';
  List<String> list1 = ['Present', 'Late', 'Absent'];
  List<String> list2 = ['Late', 'Present', 'Absent'];
  List<String> list3 = ['Absent', 'Late', 'Present'];
  List<String> listTemp = ['Present', 'Late', 'Absent'];

  TextEditingController topicController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController selectedValueController = TextEditingController();
  TextEditingController topicControllerNew = TextEditingController();
  TextEditingController messageControllerNew = TextEditingController();
  TextEditingController selectedValueControllerNew = TextEditingController();

  AttendanceReport? _attendanceReport;
  List<ReportData> listReportData = [];
  List<HistoryReport> listHistoryReport = [];
  ReportData? _reportData;
  late ProgressDialog _progressDialog;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchData();
    _progressDialog = ProgressDialog(context,
        customBody: Container(
          width: 200,
          height: 150,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
          child: const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppColors.primaryButton,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Loading',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
        ));
  }

  void _fetchData() async {
    var temp = await API(context).getReports();
    if (temp.isNotEmpty) {
      var temp2 = await API(context)
          .getReportStudentClass(temp.first.classID, temp.first.reportID);
      setState(() {
        listReportData = temp;
        _reportData = temp.first;
        _attendanceReport = temp2;
        listHistoryReport = temp2!.historyReports;
      });
    }
  }

  void updateData(String classID, int reportID, ReportData reportData) {
    API(context).getReportStudentClass(classID, reportID).then((value) {
      setState(() {
        _attendanceReport = value;
        _reportData = reportData;
        if (_attendanceReport!.feedback != null) {
          selectedValue = _attendanceReport!.feedback!.confirmStatus;
        } else {
          selectedValue = 'Present';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      color: AppColors.backgroundColor,
      child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: _attendanceReport != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const CustomText(
                          message: 'Reports',
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryText),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 300,
                            height: 600,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: CustomText(
                                      message: 'Students',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryText),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 300,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Table(
                                    columnWidths: const {
                                      0: FixedColumnWidth(50),
                                      1: FixedColumnWidth(70),
                                      2: FixedColumnWidth(70),
                                      3: FixedColumnWidth(90),
                                    },
                                    border: TableBorder.all(
                                        color: AppColors.secondaryText),
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              child: const Center(
                                                child: CustomText(
                                                    message: 'ReportID',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              child: const Center(
                                                child: CustomText(
                                                    message: 'ID',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
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
                                              child: const Center(
                                                child: CustomText(
                                                    message: 'Class',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      for (var student in listReportData)
                                        TableRow(
                                          children: [
                                            InkWell(
                                              mouseCursor:
                                                  SystemMouseCursors.click,
                                              onTap: () {
                                                updateData(student.classID,
                                                    student.reportID, student);
                                                print(
                                                    'Tapped--------------------------');
                                              },
                                              child: TableCell(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: CustomText(
                                                      message: student.reportID
                                                          .toString(),
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              mouseCursor:
                                                  SystemMouseCursors.click,
                                              child: TableCell(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: CustomText(
                                                      message:
                                                          student.studentID,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              mouseCursor:
                                                  SystemMouseCursors.click,
                                              child: TableCell(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: CustomText(
                                                      message:
                                                          student.studentName,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              mouseCursor:
                                                  SystemMouseCursors.click,
                                              child: TableCell(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: cusTomText(
                                                      student.courseName,
                                                      11,
                                                      FontWeight.normal,
                                                      Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _attendanceReport != null
                              ? Container(
                                  width: 390,
                                  height: 600,
                                  color: Colors.white,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const CustomText(
                                                    message: 'Details',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.primaryText),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 65,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              _attendanceReport!
                                                                      .isNew
                                                                  ? AppColors
                                                                      .textApproved
                                                                  : AppColors
                                                                      .primaryText,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5))),
                                                      child: Center(
                                                        child: CustomText(
                                                            message:
                                                                _attendanceReport!
                                                                        .isNew
                                                                    ? 'New'
                                                                    : 'Old',
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Container(
                                                      width: 65,
                                                      height: 20,
                                                      decoration: const BoxDecoration(
                                                          color: Color.fromARGB(
                                                              113,
                                                              190,
                                                              188,
                                                              188),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                      child: Center(
                                                        child: CustomText(
                                                            message:
                                                                'ID:${_attendanceReport!.reportID.toString()}',
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: AppColors
                                                                .primaryText),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 390,
                                          color: const Color(0xfff6f9ff),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, right: 8.0, top: 20),
                                            child: CustomText(
                                                message: 'Basic Details',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryText),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 160,
                                          width: 390,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 260,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            top: 20,
                                                            bottom: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        customRichText(
                                                          title: 'Name ',
                                                          message: _reportData!
                                                              .studentName,
                                                          fontWeightTitle:
                                                              FontWeight.w600,
                                                          fontWeightMessage:
                                                              FontWeight.normal,
                                                          colorText: AppColors
                                                              .primaryText
                                                              .withOpacity(0.3),
                                                          fontSize: 12,
                                                          colorTextMessage:
                                                              AppColors
                                                                  .primaryText,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        customRichText(
                                                          title: 'StudentID: ',
                                                          message: _reportData!
                                                              .studentID,
                                                          fontWeightTitle:
                                                              FontWeight.w600,
                                                          fontWeightMessage:
                                                              FontWeight.normal,
                                                          colorText: AppColors
                                                              .primaryText
                                                              .withOpacity(0.3),
                                                          fontSize: 12,
                                                          colorTextMessage:
                                                              AppColors
                                                                  .primaryText,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        customRichText(
                                                          title: 'Mail: ',
                                                          message:
                                                              '${_reportData!.studentID}@student.tdtu.edu.vn',
                                                          fontWeightTitle:
                                                              FontWeight.w600,
                                                          fontWeightMessage:
                                                              FontWeight.normal,
                                                          colorText: AppColors
                                                              .primaryText
                                                              .withOpacity(0.3),
                                                          fontSize: 12,
                                                          colorTextMessage:
                                                              AppColors
                                                                  .primaryText,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        customRichText(
                                                          title: 'Class: ',
                                                          message: _reportData!
                                                              .courseName,
                                                          fontWeightTitle:
                                                              FontWeight.w600,
                                                          fontWeightMessage:
                                                              FontWeight.normal,
                                                          colorText: AppColors
                                                              .primaryText
                                                              .withOpacity(0.3),
                                                          fontSize: 12,
                                                          colorTextMessage:
                                                              AppColors
                                                                  .primaryText,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        customRichText(
                                                          title:
                                                              'Shift - Room:  ',
                                                          message:
                                                              '${_reportData!.shiftNumber} - ${_reportData!.roomNumber}',
                                                          fontWeightTitle:
                                                              FontWeight.w600,
                                                          fontWeightMessage:
                                                              FontWeight.normal,
                                                          colorText: AppColors
                                                              .primaryText
                                                              .withOpacity(0.3),
                                                          fontSize: 12,
                                                          colorTextMessage:
                                                              AppColors
                                                                  .primaryText,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20, right: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        customRichText(
                                                          title:
                                                              'Report Status: ',
                                                          message: _reportData!
                                                              .status,
                                                          fontWeightTitle:
                                                              FontWeight.bold,
                                                          fontWeightMessage:
                                                              FontWeight.bold,
                                                          colorText: AppColors
                                                              .primaryText
                                                              .withOpacity(0.3),
                                                          fontSize: 12,
                                                          colorTextMessage:
                                                              getColorForStatusReport(
                                                                  _reportData!
                                                                      .status),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        customRichText(
                                                          title: 'Note: ',
                                                          message:
                                                              ' ${_attendanceReport!.attendanceDetail.note}',
                                                          fontWeightTitle:
                                                              FontWeight.w600,
                                                          fontWeightMessage:
                                                              FontWeight.normal,
                                                          colorText: AppColors
                                                              .primaryText
                                                              .withOpacity(0.3),
                                                          fontSize: 12,
                                                          colorTextMessage:
                                                              AppColors
                                                                  .primaryText,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        customRichText(
                                                          title:
                                                              'Status Attendance: ',
                                                          message: getResult(
                                                              _attendanceReport!
                                                                  .attendanceDetail
                                                                  .result),
                                                          fontWeightTitle:
                                                              FontWeight.w600,
                                                          fontWeightMessage:
                                                              FontWeight.bold,
                                                          colorText: AppColors
                                                              .primaryText
                                                              .withOpacity(0.3),
                                                          fontSize: 12,
                                                          colorTextMessage:
                                                              getColorForResult(getResult(
                                                                  _attendanceReport!
                                                                      .attendanceDetail
                                                                      .result)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 390,
                                          color: const Color(0xfff6f9ff),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, right: 8.0, top: 20),
                                            child: CustomText(
                                                message: 'About Report',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryText),
                                          ),
                                        ),
                                        SizedBox(
                                            width: 390,
                                            height: 335,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, top: 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SizedBox(
                                                    width: 195,
                                                    height: 335,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const CustomText(
                                                            message:
                                                                'Description',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .primaryText),
                                                        Container(
                                                          width: 195,
                                                          height: 300,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          5)),
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .secondaryText)),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          8.0),
                                                              child: CustomText(
                                                                  message:
                                                                      ' ${_reportData!.message}',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: AppColors
                                                                      .primaryText),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  SizedBox(
                                                    width: 185,
                                                    height: 340,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const CustomText(
                                                            message:
                                                                'Evidence of the problem',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .primaryText),
                                                        _attendanceReport!
                                                                .reportImages
                                                                .isNotEmpty
                                                            ? SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: _attendanceReport!
                                                                      .reportImages
                                                                      .map((e) {
                                                                    return Center(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            InkWell(
                                                                          mouseCursor:
                                                                              SystemMouseCursors.click,
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Image.network(
                                                                            e.imageURL,
                                                                            width:
                                                                                185,
                                                                            height:
                                                                                200,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              )
                                                            : Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Opacity(
                                                                      opacity:
                                                                          0.3,
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/nodata.png',
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            150,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    CustomText(
                                                                        message:
                                                                            'No data',
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .primaryText
                                                                            .withOpacity(0.3))
                                                                  ],
                                                                ),
                                                              )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 300,
                                  height: 600,
                                  color: Colors.white,
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                ),
                          _attendanceReport != null &&
                                  _attendanceReport!.feedback != null
                              ? widgetFeedback()
                              : sendFeedBack()
                        ],
                      )
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: Image.asset(
                          'assets/images/nodata.png',
                          width: 200,
                          height: 200,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                          message: 'No Data Reports',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText.withOpacity(0.3))
                    ],
                  ),
                )),
    );
  }

  Color getColorForResult(String result) {
    if (result == 'Present') {
      return AppColors.textApproved;
    } else if (result == 'Late') {
      return const Color.fromARGB(231, 236, 165, 78);
    } else {
      return AppColors.importantText;
    }
  }

  String getResult(dynamic result) {
    if (result.toString() == '1') {
      return 'Present';
    } else if (result.toString() == '0.5') {
      return 'Late';
    } else {
      return 'Absent';
    }
  }

  Widget sendFeedBack() {
    return SizedBox(
      width: 280,
      height: 630,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 280,
                height: 350,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          message: 'FeedBack',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(53, 226, 240, 253),
                              disabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              label: customRichText(
                                  title: 'To: ',
                                  message: _reportData != null &&
                                          _reportData!.studentName.isNotEmpty
                                      ? _reportData!.studentName
                                      : '',
                                  fontWeightTitle: FontWeight.normal,
                                  fontWeightMessage: FontWeight.normal,
                                  colorText:
                                      AppColors.primaryText.withOpacity(0.5),
                                  fontSize: 12,
                                  colorTextMessage:
                                      AppColors.primaryText.withOpacity(0.5))),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 50,
                        child: SingleChildScrollView(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty || value == '') {
                                return "This field cannot be empty";
                              }
                              return null;
                            },
                            controller: topicControllerNew,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: AppColors.primaryText),
                            maxLines: null,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color.fromARGB(53, 226, 240, 253),
                                disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                hintText: 'Topic'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(53, 226, 240, 253),
                        ),
                        child: DropdownButton<String>(
                          value: newSelectedValue,
                          onChanged: (value) {
                            setState(() {
                              newSelectedValue = value!;
                              selectedValueControllerNew.text =
                                  newSelectedValue;
                            });
                          },
                          items: listTemp
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primaryText,
                          ),
                          underline: Container(),
                          isExpanded: true,
                        ),
                      ),
                      Container(
                        height: 100,
                        // width: 280,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(53, 226, 240, 253)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SingleChildScrollView(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return "This field cannot be empty";
                                }
                                return null;
                              },
                              maxLines: null,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.primaryText),
                              controller: messageControllerNew,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Message',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          buttonName: 'Send',
                          backgroundColorButton: AppColors.primaryButton,
                          borderColor: Colors.transparent,
                          textColor: Colors.white,
                          function: () async {
                            if (_formKey.currentState!.validate()) {
                              //send Feedback
                              _progressDialog.show();
                              print('selected: $newSelectedValue');
                              bool check = await API(context).submitFeedback(
                                  _reportData!.reportID,
                                  topicControllerNew.text,
                                  messageControllerNew.text,
                                  newSelectedValue);
                              if (check) {
                                await _progressDialog.hide();
                                if (mounted) {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text('Successfully'),
                                        content: const Text(
                                            'Send feedback to student'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                topicControllerNew.text = '';
                                                messageControllerNew.text = '';
                                                newSelectedValue = 'Present';
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                await _progressDialog.hide();
                                if (mounted) {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text('Successfully'),
                                        content: const Text(
                                            'Send feedback to student'),
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
                              }
                            }
                          },
                          height: 35,
                          width: 260,
                          fontSize: 15,
                          colorShadow: AppColors.primaryButton.withOpacity(0.5),
                          borderRadius: 5)
                    ],
                  ),
                )),

            const SizedBox(
              height: 10,
            ),
            // widgetRecentFeedback(),
          ],
        ),
      ),
    );
  }

  Widget widgetFeedback() {
    selectedValue ??= _attendanceReport!.feedback!.confirmStatus;
    if (_attendanceReport != null && _attendanceReport!.feedback != null) {
      topicController.text = _attendanceReport!.feedback!.topic ?? '';
      messageController.text = _attendanceReport!.feedback!.message ?? '';
      selectedValueController.text = _attendanceReport!.feedback!.confirmStatus ?? 'Absent';
      return SizedBox(
        width: 280,
        height: 630,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 280,
                  height: 350,
                  color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                            message: 'FeedBack',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText),
                        SizedBox(
                          height: 30,
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(53, 226, 240, 253),
                                disabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                label: customRichText(
                                    title: 'To: ',
                                    message: _reportData != null &&
                                            _reportData!.studentName.isNotEmpty
                                        ? _reportData!.studentName
                                        : '',
                                    fontWeightTitle: FontWeight.normal,
                                    fontWeightMessage: FontWeight.normal,
                                    colorText:
                                        AppColors.primaryText.withOpacity(0.5),
                                    fontSize: 12,
                                    colorTextMessage: AppColors.primaryText
                                        .withOpacity(0.5))),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 50,
                          child: SingleChildScrollView(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return "This field cannot be empty";
                                }
                                return null;
                              },
                              controller: topicController,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.primaryText),
                              maxLines: null,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color.fromARGB(53, 226, 240, 253),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  hintText: 'Topic'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(53, 226, 240, 253),
                          ),
                          child: DropdownButton<String>(
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                                selectedValueController.text = selectedValue!;
                              });
                            },
                            items: listTemp
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryText,
                            ),
                            underline: Container(),
                            isExpanded: true,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 100,
                          // width: 280,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(53, 226, 240, 253)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SingleChildScrollView(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty || value == '') {
                                    return "This field cannot be empty";
                                  }
                                  return null;
                                },
                                maxLines: null,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.primaryText),
                                controller: messageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Message',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            buttonName: _attendanceReport!.isNew == true
                                ? 'Send'
                                : 'Edit',
                            backgroundColorButton: AppColors.primaryButton,
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                            function: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_attendanceReport!.isNew == true) {
                                  //send Feedback
                                  _progressDialog.show();
                                  bool check = await API(context)
                                      .submitFeedback(
                                          _reportData!.reportID,
                                          topicController.text,
                                          messageController.text,
                                          // selectedValueController.text);
                                          selectedValue ?? 'Absent');
                                  if (check) {
                                    await _progressDialog.hide();
                                    if (mounted) {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text('Successfully'),
                                            content: const Text(
                                                'Send feedback to student'),
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
                                  } else {
                                    await _progressDialog.hide();
                                    if (mounted) {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text('Error'),
                                            content: const Text(
                                                'Failed to send feedback'),
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
                                  }
                                } else {
                                  //editFeedBack
                                  print('Edit');
                                  print('selectedPage: $selectedValue');

                                  _progressDialog.show();
                                  bool check = await API(context).editFeedback(
                                      _reportData!.reportID,
                                      topicController.text,
                                      messageController.text,
                                      selectedValue!);
                                  if (check) {
                                    await _progressDialog.hide();
                                    if (mounted) {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text('Successfully'),
                                            content: const Text(
                                                'Edit feedback to student'),
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
                                  } else {
                                    await _progressDialog.hide();
                                    if (mounted) {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text('Error'),
                                            content: const Text(
                                                'Failed to edit feedback'),
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
                                  }
                                }
                              }
                            },
                            height: 35,
                            width: 260,
                            fontSize: 15,
                            colorShadow:
                                AppColors.primaryButton.withOpacity(0.5),
                            borderRadius: 5)
                      ],
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              _attendanceReport!.historyReports.isNotEmpty
                  ? historyReports()
                  : Container() //note
            ],
          ),
        ),
      );
    } else {
      return const Center(
        child: Text('Error failed'),
      );
    }
  }

  Widget historyReports() {
    print(listHistoryReport);
    return Container(
      width: 280,
      height: 270,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                    message: 'Recent Feedbacks',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText),
                CustomButton(
                    buttonName: 'View All',
                    backgroundColorButton:
                        const Color.fromARGB(68, 190, 188, 188),
                    borderColor: Colors.transparent,
                    textColor: AppColors.primaryText,
                    function: () {},
                    height: 15,
                    width: 45,
                    fontSize: 8,
                    colorShadow: Colors.transparent,
                    borderRadius: 2)
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _attendanceReport!.historyReports.length,
                    itemBuilder: (context, index) {
                      HistoryReport historyReport = _attendanceReport!.historyReports[index];
                      return InkWell(
                        onTap: () {
                          showHistoryReport(context, historyReport);
                        },
                        child: SizedBox(
                          width: 280,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cusTomText(
                                  '#${historyReport.historyReportID ?? ''} Responed to ${historyReport.topic ?? ''}',
                                  12,
                                  FontWeight.normal,
                                  AppColors.primaryText),
                              Container(
                                width: 50,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: getColorForStatusReport(
                                        historyReport.status ?? ''),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: Center(
                                  child: Text(
                                    historyReport.status ?? '',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }

  Future<dynamic> showHistoryReport(
          BuildContext context, HistoryReport historyReport) =>
      showDialog(
          context: context,
          builder: (context) {
            print(
                'alo alo: ${_attendanceReport!.attendanceDetail.classDetail}');
            print('asdsad: ${historyReport.historyReportID!}');
            return Dialog(
                backgroundColor: Colors.white,
                child: FutureBuilder(
                    future: API(context).getDetailHistoryReport(
                        _attendanceReport!.attendanceDetail.classDetail,
                        historyReport.historyReportID!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          HistoryReportDialog? historyReportDialog =
                              snapshot.data;
                          return Container(
                            height: MediaQuery.of(context).size.height - 100,
                            width: MediaQuery.of(context).size.width - 350,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      historyDetailReports(historyReportDialog),
                                      historyReportDialog!.historyFeedbacks !=
                                              null
                                          ? historyFeedbacks(
                                              historyReportDialog)
                                          : Container(),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  width: 600,
                                  color: Colors.white,
                                  child: historyReportDialog
                                          .historyReportImages!.isNotEmpty
                                      ? Center(
                                          child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: historyReportDialog
                                                .historyReportImages!
                                                .map((e) {
                                              return SizedBox(
                                                  height: 300,
                                                  width: 300,
                                                  child: Image.network(
                                                      e.imageURL));
                                            }).toList(),
                                          ),
                                        ))
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: 300,
                                                width: 300,
                                                child: Opacity(
                                                    opacity: 0.3,
                                                    child: Image.asset(
                                                        'assets/images/nodata.png'))),
                                            const CustomText(
                                                message: 'No Image',
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.primaryText)
                                          ],
                                        ),
                                )
                              ],
                            ),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return const Center(
                        child: Text('Data is not available'),
                      );
                    }));
          });

  Widget historyDetailReports(HistoryReportDialog? historyReportDialog) {
    return Expanded(
      child: Container(
        // height: 200,
        // width: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.all(color: Colors.white.withOpacity(0.3), width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                        message: 'History Reports',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText),
                    Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Center(
                          child: CustomText(
                              message:
                                  'ID: ${historyReportDialog!.historyReportID ?? ''}',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryText)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                customRichText2(historyReportDialog.topic ?? '', 'Topic: ',
                    AppColors.primaryText.withOpacity(0.5)),
                const SizedBox(
                  height: 10,
                ),
                customRichText2(historyReportDialog.problem ?? '', 'Problem: ',
                    AppColors.primaryText.withOpacity(0.5)),
                const SizedBox(
                  height: 10,
                ),
                customRichText2(historyReportDialog.status ?? '', 'Status: ',
                    getColorForStatusReport(historyReportDialog.status ?? '')),
                const SizedBox(
                  height: 10,
                ),
                customRichText2(formatDate(historyReportDialog.createdAt),
                    'Created Date: ', AppColors.primaryText.withOpacity(0.5)),
                const SizedBox(
                  height: 10,
                ),
                customRichText2(formatTime(historyReportDialog.createdAt),
                    'Created Time: ', AppColors.primaryText.withOpacity(0.5)),
                const SizedBox(
                  height: 10,
                ),
                customRichText2(historyReportDialog.message ?? '', 'Message: ',
                    AppColors.primaryText.withOpacity(0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container historyFeedbacks(HistoryReportDialog? historyReportDialog) {
    return Container(
      height: 200,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                      message: 'History Feedbacks',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText),
                  Container(
                    height: 20,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Center(
                        child: CustomText(
                            message:
                                'ID: ${historyReportDialog!.historyFeedbacks!.historyFeedbackID ?? ''}',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primaryText)),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              customRichText2(historyReportDialog.historyFeedbacks!.topic ?? '',
                  'Topic: ', AppColors.primaryText.withOpacity(0.5)),
              const SizedBox(
                height: 10,
              ),
              customRichText2(
                  historyReportDialog.historyFeedbacks!.confirmStatus ?? '',
                  'Status: ',
                  getColorForStatusReport(
                      historyReportDialog.historyFeedbacks!.confirmStatus ??
                          '')),
              const SizedBox(
                height: 10,
              ),
              customRichText2(
                  formatDate(
                      historyReportDialog.historyFeedbacks!.createdAt ?? ''),
                  'Created Date: ',
                  AppColors.primaryText.withOpacity(0.5)),
              const SizedBox(
                height: 10,
              ),
              customRichText2(
                  formatTime(
                      historyReportDialog.historyFeedbacks!.createdAt ?? ''),
                  'Created Time: ',
                  AppColors.primaryText.withOpacity(0.5)),
              const SizedBox(
                height: 10,
              ),
              customRichText2(
                  historyReportDialog.historyFeedbacks!.message ?? '',
                  'Message: ',
                  AppColors.primaryText.withOpacity(0.5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget customRichText2(String message, String title, Color color) {
    return Text.rich(
      TextSpan(
        text: title,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryText,
        ),
        children: [
          TextSpan(
            text: message,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              color: color,
            ),
          ),
        ],
      ),
      maxLines: null,
    );
  }

  Color getColorForStatusReport(String result) {
    if (result == 'Approved') {
      return AppColors.textApproved;
    } else if (result == 'Pending') {
      return const Color.fromARGB(231, 216, 136, 38);
    } else {
      return AppColors.importantText;
    }
  }

  // Container widgetRecentFeedback() {
  //   return Container(
  //       width: 280,
  //       height: 270,
  //       color: Colors.white,
  //       child: const Text(
  //         'alo alo',
  //         style: TextStyle(color: Colors.black),
  //       ));
  // }

  Widget cusTomText(
      String message, double fontSize, FontWeight fontWeight, Color color) {
    return Text(message,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.inter(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}
