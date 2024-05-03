import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomRichText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/EditPage/HistoryEdition.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/EditPage/StudentAttendance.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/HomePage.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';

class EditAttendanceDetail extends StatefulWidget {
  const EditAttendanceDetail(
      {super.key,
      required this.studentID,
      // required this.classID,
      required this.formID,
      required this.studentName,
      required this.classes});
  final String? studentID;
  // final String? classID;
  final String? formID;
  final String? studentName;
  final Class? classes;

  @override
  State<EditAttendanceDetail> createState() => _EditAttendanceDetailState();
}

class _EditAttendanceDetailState extends State<EditAttendanceDetail> {
  TextEditingController topicController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String selectedValue = 'Lectuer take attendance';
  late Future<StudentAttendanceEdit?> _fetchStudentAttendance;
  StudentAttendanceEdit? _studentAttendance;
  late ProgressDialog _progressDialog;

  @override
  void initState() {
    // TODO: implement initState
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
    _fetchStudentAttendance = API(context).getAttendanceDetailStudent(
        widget.classes?.classID ?? '',
        widget.studentID ?? '',
        widget.formID ?? '');
    _fetchStudentAttendance.then((value) {
      setState(() {
        _studentAttendance = value!;
      });
      print('_student: ${_studentAttendance == null}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return _studentAttendance != null
        ? Container(
            width: MediaQuery.of(context).size.width - 250,
            height: MediaQuery.of(context).size.height,
            color: AppColors.backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomText(
                            message: 'Edit',
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryText),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                // width: 390,
                                // height: 550,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: AppColors.primaryText
                                            .withOpacity(0.1),
                                        width: 0.5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.primaryText
                                              .withOpacity(0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 1))
                                    ]),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const CustomText(
                                                  message: 'Details',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primaryText),
                                              Container(
                                                width: 65,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: chooseColor(
                                                        getStatusResult(
                                                            _studentAttendance!
                                                                    .result ??
                                                                '')),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                child: Center(
                                                  child: CustomText(
                                                      message: getStatusResult(
                                                          _studentAttendance!
                                                                  .result ??
                                                              ''),
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // height: 50,
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        color: const Color(0xfff6f9ff),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: CustomText(
                                              message: 'Basic Details',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryText),
                                        ),
                                      ),
                                      SizedBox(
                                        // height: 150,
                                        // width: 390,
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              // width: 260,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 20,
                                                    bottom: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    customRichText(
                                                      title: 'Name: ',
                                                      message:
                                                          widget.studentName ??
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
                                                          AppColors.primaryText,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    customRichText(
                                                      title: 'StudentID: ',
                                                      message: _studentAttendance!
                                                              .studentDetail ??
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
                                                          AppColors.primaryText,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    customRichText(
                                                      title: 'Mail: ',
                                                      message:
                                                          '${_studentAttendance!.studentDetail ?? ''}@student.tdtu.edu.vn',
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
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    customRichText(
                                                      title: 'Class: ',
                                                      message: widget
                                                              .classes!
                                                              .course!
                                                              .courseName ??
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
                                                          AppColors.primaryText,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    customRichText(
                                                      title: 'Shift - Room:  ',
                                                      message:
                                                          '${widget.classes!.shiftNumber ?? 0} - ${widget.classes!.roomNumber ?? ''}',
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
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // height: 50,
                                        // width: 390,
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),

                                        color: const Color(0xfff6f9ff),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: CustomText(
                                              message:
                                                  'Eividence of the problem',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryText),
                                        ),
                                      ),
                                      _studentAttendance!.url == '' ||
                                              _studentAttendance!.url == null
                                          ? SizedBox(
                                              width: 390,
                                              height: 335,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Opacity(
                                                  opacity: 0.3,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/nodata.png',
                                                        width: 200,
                                                        height: 200,
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      const CustomText(
                                                          message:
                                                              'No Image Evidence',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors
                                                              .primaryText)
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          : Image.network(
                                              _studentAttendance!.url!,
                                              width: 390,
                                              height: 335,
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Container(
                                  // width: 260,
                                  // height: 550,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: AppColors.primaryText
                                              .withOpacity(0.1),
                                          width: 0.2),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.primaryText
                                                .withOpacity(0.2),
                                            blurRadius: 2,
                                            offset: const Offset(0, 1))
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(
                                            message: 'Edition',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryText),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 30,
                                          child: TextFormField(
                                            readOnly: true,
                                            enabled: false,
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: const Color.fromARGB(
                                                    53, 226, 240, 253),
                                                disabledBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                label: customRichText(
                                                    title: 'To: ',
                                                    message:
                                                        widget.studentName ??
                                                            '',
                                                    fontWeightTitle:
                                                        FontWeight.normal,
                                                    fontWeightMessage:
                                                        FontWeight.normal,
                                                    colorText: AppColors
                                                        .primaryText
                                                        .withOpacity(0.2),
                                                    fontSize: 12,
                                                    colorTextMessage: AppColors
                                                        .primaryText
                                                        .withOpacity(0.5))),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: SingleChildScrollView(
                                            child: TextFormField(
                                              controller: topicController,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: AppColors.primaryText),
                                              maxLines: null,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: AppColors
                                                          .primaryText
                                                          .withOpacity(0.2)),
                                                  filled: true,
                                                  fillColor:
                                                      const Color.fromARGB(
                                                          53, 226, 240, 253),
                                                  disabledBorder:
                                                      const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  hintText: 'Topic'),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: const Color.fromARGB(
                                                53, 226, 240, 253),
                                          ),
                                          child: DropdownButton<String>(
                                            value: selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValue = value!;
                                              });
                                            },
                                            items: <String>[
                                              'Lectuer take attendance',
                                              'Take attendance late',
                                              'Deny attendance'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
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
                                          height: 320,
                                          // width: 280,
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  53, 226, 240, 253)),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: TextFormField(
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: CustomButton(
                                              buttonName: 'Send',
                                              backgroundColorButton:
                                                  AppColors.primaryButton,
                                              borderColor: Colors.transparent,
                                              textColor: Colors.white,
                                              function: () async {
                                                _progressDialog.show();
                                                bool check = await API(context)
                                                    .editAttendanceDetail(
                                                        widget.studentID ?? '',
                                                        widget.classes
                                                                ?.classID ??
                                                            '',
                                                        widget.formID ?? '',
                                                        topicController.text ??
                                                            '',
                                                        getConfirmStatus(
                                                                selectedValue) ??
                                                            'Deny attendance',
                                                        messageController.text);
                                                if (check) {
                                                  await _progressDialog.hide();
                                                  await showDialog(
                                                      context: context,
                                                      builder: (builder) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                                'Edit Attendance Detail'),
                                                            content: Text(
                                                                'Edit attendance ${widget.studentID} succcessfully'),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'OK'))
                                                            ],
                                                          ));
                                                } else {
                                                  await _progressDialog.hide();
                                                  await showDialog(
                                                      context: context,
                                                      builder: (builder) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                                'Edit Attendance Detail'),
                                                            content: Text(
                                                                'Failed edit attendance ${widget.studentID}'),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'OK'))
                                                            ],
                                                          ));
                                                }
                                              },
                                              height: 40,
                                              width: 260,
                                              fontSize: 15,
                                              colorShadow: AppColors
                                                  .primaryButton
                                                  .withOpacity(0.7),
                                              borderRadius: 5),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: ,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  historyEdition(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  newReports(),
                                  const SizedBox(
                                    height: 50,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width - 250,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  String getConfirmStatus(String confirmStatus) {
    if (confirmStatus == 'Lectuer take attendance') {
      return 'Present';
    } else if (confirmStatus == 'Take attendance late') {
      return 'Late';
    } else {
      return 'Absent';
    }
  }

  Widget historyEdition() {
    return Container(
      width: 280,
      height: 200,
      // padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: AppColors.primaryText.withOpacity(0.1), width: 0.2),
          boxShadow: [
            BoxShadow(
                color: AppColors.primaryText.withOpacity(0.2),
                blurRadius: 2,
                offset: const Offset(0, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
                message: 'History Edition',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _studentAttendance!.histories!.length,
                    itemBuilder: (context, index) {
                      HistoryEdition historyReport =
                          _studentAttendance!.histories![index];
                      return InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: 280,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cusTomText(
                                  '#${historyReport.feedbackID} Responed to ${historyReport.topic}',
                                  12,
                                  FontWeight.normal,
                                  AppColors.primaryText),
                              Container(
                                width: 50,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: getColorForStatusHistoryEdition(
                                        historyReport.confirmStatus ?? ''),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: Center(
                                  child: Text(
                                    historyReport.confirmStatus ?? '',
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

  Widget newReports() {
    return _studentAttendance!.report != null
        ? Container(
            width: 280,
            // height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: AppColors.primaryText.withOpacity(0.1), width: 0.2),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primaryText.withOpacity(0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                      message: 'Reports',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 280,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cusTomText(
                            '${_studentAttendance!.studentDetail ?? ''} has sent report ${_studentAttendance!.report!.reportID ?? 0}',
                            12,
                            FontWeight.normal,
                            AppColors.primaryText),
                        Container(
                          width: 50,
                          height: 15,
                          decoration: BoxDecoration(
                              color: getColorForStatusHistoryEdition(
                                  _studentAttendance!.report!.status ?? ''),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              _studentAttendance!.report!.status ?? '',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 8),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            width: 280,
            // height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: AppColors.primaryText.withOpacity(0.1), width: 0.2),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primaryText.withOpacity(0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                          message: 'Reports',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                     
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: CustomText(
                        message: 'No Report New',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryText),
                  )
                ],
              ),
            ),
          );
  }

  Color getColorForStatusHistoryEdition(String result) {
    if (result == 'Present') {
      return AppColors.textApproved;
    } else if (result == 'Late') {
      return const Color.fromARGB(231, 216, 136, 38);
    } else {
      return AppColors.importantText;
    }
  }

  Widget cusTomText(
      String message, double fontSize, FontWeight fontWeight, Color color) {
    return Text(message,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.inter(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }

  Widget header() {
    return Container(
      width: double.infinity,
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

String getStatusResult(String result) {
  if (result == '1') {
    return 'Present';
  } else if (result == '0.5') {
    return 'Late';
  } else {
    return 'Absent';
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
