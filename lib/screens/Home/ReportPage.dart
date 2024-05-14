import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  int page = 1;
  int totalPage = 1;

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
    var temp = await API(context).getReportsWithPagi(page);
    if (temp != null && temp.reports!.isNotEmpty) {
      var temp2 = await API(context).getReportStudentClass(
          temp.reports?.first.classID ?? '', temp.reports?.first.reportID ?? 0);
      setState(() {
        listReportData = temp.reports ?? [];
        _reportData = temp.reports?.first;
        _attendanceReport = temp2;
        listHistoryReport = temp2!.historyReports;
        totalPage = temp.totalPage ?? 1;
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
      child: _attendanceReport != null
          ? SingleChildScrollView(
              child: _attendanceReport != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: CustomText(
                              message: 'Reports',
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryText),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                          message: 'Students',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryText),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(1),
                                          1: FlexColumnWidth(1),
                                          2: FlexColumnWidth(2),
                                          3: FlexColumnWidth(2),
                                          4: FlexColumnWidth(0.5),
                                          5: FlexColumnWidth(1)
                                        },
                                        border: TableBorder.all(
                                            color: AppColors.secondaryText),
                                        children: [
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Container(
                                                  color: const Color(0xff1770f0)
                                                      .withOpacity(0.8),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: const Center(
                                                    child: CustomText(
                                                        message: 'ReportID',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  color: const Color(0xff1770f0)
                                                      .withOpacity(0.8),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: const Center(
                                                    child: CustomText(
                                                        message: 'StudentID',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  color: const Color(0xff1770f0)
                                                      .withOpacity(0.8),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: const Center(
                                                    child: CustomText(
                                                        message: 'Name',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  color: const Color(0xff1770f0)
                                                      .withOpacity(0.8),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: const Center(
                                                    child: CustomText(
                                                        message: 'Class',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  color: const Color(0xff1770f0)
                                                      .withOpacity(0.8),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: const Center(
                                                    child: CustomText(
                                                        message: 'Status',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  color: const Color(0xff1770f0)
                                                      .withOpacity(0.8),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: const Center(
                                                    child: CustomText(
                                                        message: 'Created',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
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
                                                    updateData(
                                                        student.classID ?? '',
                                                        student.reportID ?? 0,
                                                        student);
                                                  },
                                                  child: TableCell(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Center(
                                                        child: CustomText(
                                                            message: student
                                                                .reportID
                                                                .toString(),
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Center(
                                                        child: CustomText(
                                                            message: student
                                                                    .studentID ??
                                                                '',
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Center(
                                                        child: CustomText(
                                                            message: student
                                                                    .studentName ??
                                                                '',
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Center(
                                                        child: cusTomText(
                                                            student.courseName ??
                                                                '',
                                                            11,
                                                            FontWeight.normal,
                                                            Colors.black),
                                                      ),
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Center(
                                                        child: CustomText(
                                                            message: getIsNew(
                                                                student.isNew ??
                                                                    0),
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Center(
                                                        child: CustomText(
                                                            message:
                                                                '${formatDate(student.createdAt ?? '')}, ${formatTime(student.createdAt ?? '')}',
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: AppColors
                                                                .primaryText),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      _buildPaginationButtons(totalPage),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //FutureBuilder
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: CustomText(
                                                    message: 'Details',
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.primaryText),
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: 65,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: _attendanceReport!
                                                                .isNew
                                                            ? AppColors
                                                                .textApproved
                                                            : AppColors
                                                                .primaryText,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
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
                                                              FontWeight.normal,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width: 65,
                                                    height: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                Color
                                                                    .fromARGB(
                                                                        113,
                                                                        190,
                                                                        188,
                                                                        188),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                    child: Center(
                                                      child: CustomText(
                                                          message:
                                                              'ID:${_attendanceReport!.reportID.toString()}',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: AppColors
                                                              .primaryText),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      // const SizedBox(height:5 ,),
                                      Container(
                                        width: double.infinity,
                                        color: const Color(0xfff6f9ff),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: const CustomText(
                                              message: 'Basic Details',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryText),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          customRichText(
                                                            title: 'Name ',
                                                            message: _reportData
                                                                    ?.studentName ??
                                                                '',
                                                            fontWeightTitle:
                                                                FontWeight.w600,
                                                            fontWeightMessage:
                                                                FontWeight
                                                                    .normal,
                                                            colorText: AppColors
                                                                .primaryText
                                                                .withOpacity(
                                                                    0.3),
                                                            fontSize: 12,
                                                            colorTextMessage:
                                                                AppColors
                                                                    .primaryText,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          customRichText(
                                                            title:
                                                                'StudentID: ',
                                                            message: _reportData
                                                                    ?.studentID ??
                                                                '',
                                                            fontWeightTitle:
                                                                FontWeight.w600,
                                                            fontWeightMessage:
                                                                FontWeight
                                                                    .normal,
                                                            colorText: AppColors
                                                                .primaryText
                                                                .withOpacity(
                                                                    0.3),
                                                            fontSize: 12,
                                                            colorTextMessage:
                                                                AppColors
                                                                    .primaryText,
                                                          ),
                                                        ],
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
                                                        message: _reportData
                                                                ?.courseName ??
                                                            '',
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
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
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
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    customRichText(
                                                      title: 'Report Status: ',
                                                      message:
                                                          _reportData?.status ??
                                                              '',
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
                                                              _reportData
                                                                      ?.status ??
                                                                  ''),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    customRichText(
                                                      title: 'Note: ',
                                                      message:
                                                          ' ${_attendanceReport?.attendanceDetail.note}',
                                                      fontWeightTitle:
                                                          FontWeight.w600,
                                                      fontWeightMessage:
                                                          FontWeight.normal,
                                                      colorText: AppColors
                                                          .primaryText
                                                          .withOpacity(0.3),
                                                      fontSize: 12,
                                                      colorTextMessage:
                                                          AppColors.primaryText,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: _sendAndEditFeedback(context),
                            )
                          ],
                        )
                      ],
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
                    ),
            )
          : _attendanceReport == null
              ? Center(
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
                          message: 'No Reports',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText.withOpacity(0.3))
                    ],
                  ),
                )
              : const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryButton),
                ),
    );
  }

  Container _sendAndEditFeedback(BuildContext context) {
    if (_attendanceReport?.isNew == true) {
      return _sendFeedback(context);
    } else {
      selectedValue ??= _attendanceReport?.feedback?.confirmStatus;
      topicController.text = _attendanceReport?.feedback?.topic ?? '';
      messageController.text = _attendanceReport?.feedback?.message ?? '';
      selectedValueController.text =
          _attendanceReport?.feedback?.confirmStatus ?? 'Absent';
      return _editFeedback(context);
    }
  }

  Container _editFeedback(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                message: 'Edit FeedBack',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              child: TextFormField(
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xfff6f9ff),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  label: customRichText(
                    title: 'To: ',
                    message: _reportData != null &&
                            _reportData!.studentName!.isNotEmpty
                        ? _reportData?.studentName ?? ''
                        : '',
                    fontWeightTitle: FontWeight.normal,
                    fontWeightMessage: FontWeight.normal,
                    colorText: AppColors.primaryText.withOpacity(0.5),
                    fontSize: 12,
                    colorTextMessage: AppColors.primaryText.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              // height: 50,
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
                  color: AppColors.primaryText,
                ),
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xfff6f9ff),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: 'Topic',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xfff6f9ff),
              ),
              child: DropdownButton<String>(
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    newSelectedValue = value!;
                    selectedValueControllerNew.text = newSelectedValue;
                  });
                },
                items: listTemp.map<DropdownMenuItem<String>>((String value) {
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
              height: 10,
            ),
            Container(
              // height: 100,
              decoration: const BoxDecoration(
                color: Color.fromARGB(53, 226, 240, 253),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  maxLength: 200,
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
                    color: AppColors.primaryText,
                  ),
                  controller: messageController,
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: 'Message',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CustomButton(
                  buttonName: 'Edit',
                  backgroundColorButton: AppColors.primaryButton,
                  borderColor: Colors.transparent,
                  textColor: Colors.white,
                  function: () async {
                    if (_formKey.currentState!.validate()) {
                      _progressDialog.show();
                      bool check = await API(context).editFeedback(
                        _reportData!.reportID ?? 0,
                        topicController.text,
                        messageController.text,
                        newSelectedValue ?? 'Absent',
                      );
                      await _progressDialog.hide();
                      if (check) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text('Successfully'),
                              content: const Text('Edit feedback to student'),
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
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text('Failed'),
                              content:
                                  const Text('Fail edit feedback to student'),
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
                      print('error');
                    }
                  },
                  height: 40,
                  width: null,
                  fontSize: 18,
                  colorShadow: AppColors.primaryButton.withOpacity(0.5),
                  borderRadius: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _sendFeedback(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                message: 'FeedBack',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              child: TextFormField(
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xfff6f9ff),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  label: customRichText(
                    title: 'To: ',
                    message: _reportData != null &&
                            _reportData!.studentName!.isNotEmpty
                        ? _reportData?.studentName ?? ''
                        : '',
                    fontWeightTitle: FontWeight.normal,
                    fontWeightMessage: FontWeight.normal,
                    colorText: AppColors.primaryText.withOpacity(0.5),
                    fontSize: 12,
                    colorTextMessage: AppColors.primaryText.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              // height: 50,
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
                  color: AppColors.primaryText,
                ),
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xfff6f9ff),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: 'Topic',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xfff6f9ff),
              ),
              child: DropdownButton<String>(
                value: newSelectedValue,
                onChanged: (value) {
                  setState(() {
                    newSelectedValue = value!;
                    selectedValueControllerNew.text = newSelectedValue;
                  });
                },
                items: listTemp.map<DropdownMenuItem<String>>((String value) {
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
              height: 10,
            ),
            Container(
              // height: 100,
              decoration: const BoxDecoration(
                color: Color.fromARGB(53, 226, 240, 253),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  maxLength: 200,
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
                    color: AppColors.primaryText,
                  ),
                  controller: messageControllerNew,
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: 'Message',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CustomButton(
                  buttonName: 'Send',
                  backgroundColorButton: AppColors.primaryButton,
                  borderColor: Colors.transparent,
                  textColor: Colors.white,
                  function: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_attendanceReport?.isNew == true) {
                        _progressDialog.show();
                        bool check = await API(context).submitFeedback(
                          _reportData!.reportID ?? 0,
                          topicControllerNew.text,
                          messageControllerNew.text,
                          newSelectedValue ?? 'Absent',
                        );
                        await _progressDialog.hide();
                        if (check) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text('Successfully'),
                                content: const Text('Send feedback to student'),
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
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text('Failed'),
                                content:
                                    const Text('Fail send feedback to student'),
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
                  height: 40,
                  width: null,
                  fontSize: 18,
                  colorShadow: AppColors.primaryButton.withOpacity(0.5),
                  borderRadius: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getIsNew(int data) {
    if (data == 1) {
      return 'New';
    } else {
      return 'Old';
    }
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

  Widget historyReports() {
    print(listHistoryReport);
    return Container(
      // width: 280,
      height: 270,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
                message: 'Recent Feedbacks',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: ListView.separated(
              itemCount: _attendanceReport!.historyReports.length,
              itemBuilder: (context, index) {
                HistoryReport historyReport =
                    _attendanceReport!.historyReports[index];
                return InkWell(
                  onTap: () {
                    showHistoryReport(context, historyReport);
                  },
                  child: SizedBox(
                    // width: 280,
                    // height: 30,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: cusTomText(
                              '#${historyReport.historyReportID ?? ''} Responed to ${historyReport.topic ?? ''}',
                              12,
                              FontWeight.normal,
                              AppColors.primaryText),
                        ),
                        Container(
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                              color: getColorForStatusReport(
                                  historyReport.status ?? ''),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
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
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ))
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
            print('asdsad: ${historyReport.historyReportID!}');
            return Dialog(
                backgroundColor: Colors.white,
                child: FutureBuilder(
                    future: API(context).getDetailHistoryReport(
                        _attendanceReport?.attendanceDetail.classDetail ?? '',
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
                                      historyReportDialog?.historyFeedbacks !=
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
                                                  ?.historyReportImages !=
                                              null &&
                                          historyReportDialog!
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

  Widget _buildPaginationButtons(int totalPage) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: page > 1
              ? () {
                  setState(() {
                    page--;
                  });
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey.withOpacity(0.2);
                }
                return null; // Màu mặc định khi không bị vô hiệu hóa
              },
            ),
          ),
          child: const Text(
            'Previous',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        CustomText(
          message: '$page/$totalPage',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: page < totalPage
              ? () {
                  setState(() {
                    page++;
                  });
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey.withOpacity(0.2);
                }
                return null;
              },
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
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
