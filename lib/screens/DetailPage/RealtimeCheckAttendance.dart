import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/RealtimeAttendance/AttendanceData.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/RealtimeAttendance/AttendanceMode.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/socketServer_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/HomePage.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';

class RealtimeCheckAttendance extends StatefulWidget {
  const RealtimeCheckAttendance(
      {super.key, required this.formID, required this.classes});
  // final AttendanceForm? attendanceForm;
  final String formID;
  final String classes;

  @override
  State<RealtimeCheckAttendance> createState() =>
      _RealtimeCheckAttendanceState();
}

class _RealtimeCheckAttendanceState extends State<RealtimeCheckAttendance> {
  int all = 0;
  int present = 0;
  int absent = 0;
  int late = 0;
  late Future<AttendanceModel?> fetchData;
  TextEditingController searchController = TextEditingController();
  String isSelectedSection = 'All';
  int currentPage = 0;
  int studentsPerPage = 10;
  TextEditingController searchInDashboardController = TextEditingController();
  List<AttendanceData> listTemp = [];
  List<AttendanceData> studentAttendance = [];
  List<AttendanceData> presentAttendance = [];
  List<AttendanceData> absentAttendance = [];
  List<AttendanceData> lateAttendance = [];
  List<AttendanceData> searchResult = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
    var socketServerProvider =
        Provider.of<SocketServerProvider>(context, listen: false);
    var socket = socketServerProvider.socket;

    socket.on('getTakeAttendance', (data) {
      print(socket.id);
      try {
        print('DataData: $data');
        var temp = jsonDecode(data);
        var jsonData = {
          'studentDetail': temp['studentDetail'],
          'classDetail': temp['classDetail'],
          'dateTimeAttendance': temp['dateTimeAttendance'],
          'result': temp['result'].toString(),
        };
        if (mounted) {
          updateData(jsonData);
        }
      } catch (e) {
        print('Error: $e');
      }
    });
    //socketServerProvider.connectToSocketServer(widget.classes);

    // Future.delayed(Duration.zero, () {
    //   var socketServerProvider =
    //       Provider.of<SocketServerProvider>(context, listen: false);
    //   socketServerProvider.connectToSocketServer(widget.classes);
    //socketServerProvider.getAttendanceDetail();
    // socketServerProvider.attendanceStream.listen((data) {
    //   print("data from listen: ${data}");
    //   if (mounted) {
    //     updateData(data);
    //   }
    // });
    // });
    print('InitState-----as');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose");
    super.dispose();
    var socketServerProvider =
        Provider.of<SocketServerProvider>(context, listen: false);
    var socket = socketServerProvider.socket;
    socket.dispose();
    socketServerProvider.dispose();
  }

  void _fetchData() async {
    fetchData = API(context).getAttendanceDetailRealtime(widget.formID);
    final attendanceSummary = await fetchData;
    setState(() {
      studentAttendance = attendanceSummary!.data;
      print('-----${studentAttendance.first.dateAttendanced}');
      listTemp = attendanceSummary.data;
      absentAttendance =
          studentAttendance.where((element) => element.result == '0').toList();
      lateAttendance = studentAttendance
          .where((element) => element.result == '0.5')
          .toList();
      presentAttendance =
          studentAttendance.where((element) => element.result == '1').toList();
      all = attendanceSummary.stats.total;
      present = attendanceSummary.stats.totalPresence;
      absent = attendanceSummary.stats.totalAbsence;
      late = attendanceSummary.stats.totalLate;
    });

    // await API(context).getAttendanceDetailRealtime(widget.formID).then((value) {
    //   setState(() {
    //     studentAttendance = value!.data;
    //     listTemp = value!.data;
    //     absentAttendance = studentAttendance
    //         .where((element) => element.result == '0')
    //         .toList();
    //     lateAttendance = studentAttendance
    //         .where((element) => element.result == '0.5')
    //         .toList();
    //     presentAttendance = studentAttendance
    //         .where((element) => element.result == '1')
    //         .toList();
    //     all = value.stats.total;
    //     present = value.stats.totalPresence;
    //     absent = value.stats.totalAbsence;
    //     late = value.stats.totalLate;
    //   });
    // });
  }


void updateData(dynamic data) {
  String studentID = data['studentDetail'];
  for (int i = 0; i < studentAttendance.length; i++) {
    if (studentID.contains(studentAttendance[i].studentID)) {
      if (data['result'] == '1') {
        absent = absent - 1;
        present = present + 1;
        studentAttendance[i].result = data['result'];
        studentAttendance[i].dateAttendanced = data['dateTimeAttendance'];
        presentAttendance.add(studentAttendance[i]);
        absentAttendance.remove(studentAttendance[i]);
      } else if (data['result'] == '0.5') {
        late = late + 1;
        absent = absent - 1;
        studentAttendance[i].result = data['result'];
        studentAttendance[i].dateAttendanced = data['dateTimeAttendance'];
        lateAttendance.add(studentAttendance[i]);
        absentAttendance.remove(studentAttendance[i]);
      }
    }
  }
  if (mounted) {
    setState(() {});
  }
}

  // void updateData(dynamic data) {
  //   print("absent initial: ${absent}");
  //   print("present initial: ${present}");
  //   print("late initial: ${late}");
  //   String studentID = data['studentDetail'];
  //   for (int i = 0; i < studentAttendance.length; i++) {
  //     if (studentID.contains(studentAttendance[i].studentID)) {
  //       if (data['result'] == '1') {
  //         setState(() {
  //           absent = absent - 1;
  //           present = present + 1;
  //           studentAttendance[i].result = data['result'];
  //           studentAttendance[i].dateAttendanced = data['dateTimeAttendance'];
  //           presentAttendance.add(studentAttendance[i]);
  //           absentAttendance.remove(studentAttendance[i]);
  //         });
  //       } else if (data['result'] == '0.5') {
  //         setState(() {
  //           late = late + 1;
  //           absent = absent - 1;
  //           studentAttendance[i].result = data['result'];
  //           studentAttendance[i].dateAttendanced = data['dateTimeAttendance'];
  //           lateAttendance.add(studentAttendance[i]);
  //           absentAttendance.remove(studentAttendance[i]);
  //         });
  //       }
  //     }
  //   }
  // }

  void newAllListData() {
    setState(() {
      isSelectedSection = 'All';
      listTemp = studentAttendance;
      currentPage = 0;
    });
  }

  void newPresentListData() {
    setState(() {
      isSelectedSection = 'Present';
      listTemp = presentAttendance;
      currentPage = 0;
    });
  }

  void newLateListData() {
    setState(() {
      isSelectedSection = 'Late';
      listTemp = lateAttendance;
      currentPage = 0;
    });
  }

  void newAbsentListData() {
    setState(() {
      isSelectedSection = 'Absent';
      listTemp = absentAttendance;
      currentPage = 0;
    });
  }

  void newSetStateTable(String title) {
    if (title == 'All' || title.contains('All')) {
      newAllListData();
    } else if (title == 'Present' || title.contains(('Present'))) {
      newPresentListData();
    } else if (title == 'Late' || title.contains('Late')) {
      newLateListData();
    } else if (title == 'Absent' || title.contains('Absent')) {
      newAbsentListData();
    } else {
      newAllListData();
    }
  }

  void searchTextChanged(String query) {
    searchResult.clear();
    if (query.isEmpty) {
      setState(() {
        listTemp = listDataSearch(isSelectedSection);
      });
      return;
    }
    List<AttendanceData> temp = listDataSearch(isSelectedSection);
    for (var element in temp) {
      if (element.studentID.contains(query) ||
          element.studentID.toLowerCase().trim() ==
              query.toLowerCase().trim()) {
        searchResult.add(element);
      }
    }
    print('----SearchResult: $searchResult');
    setState(() {
      listTemp = searchResult;
      //currentPage = 0; nen kiem tra lai
    });
  }

  List<AttendanceData> listDataSearch(String section) {
    if (section == 'All') {
      return studentAttendance;
    } else if (section == 'Present') {
      return presentAttendance;
    } else if (section == 'Absent') {
      return absentAttendance;
    } else if (section == 'Late') {
      return lateAttendance;
    } else {
      return studentAttendance;
    }
  }

  @override
  Widget build(BuildContext context) {
    final socketServerProvider =
        Provider.of<SocketServerProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          header(socketServerProvider),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
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
                          customBoxInformation(
                              'All',
                              'assets/icons/student.png',
                              all,
                              newSetStateTable,
                              isSelectedSection),
                          customBoxInformation(
                              'Present',
                              'assets/icons/present.png',
                              present,
                              newSetStateTable,
                              isSelectedSection),
                          customBoxInformation(
                              'Absent',
                              'assets/icons/absent.png',
                              absent,
                              newSetStateTable,
                              isSelectedSection),
                          customBoxInformation(
                              'Late',
                              'assets/icons/pending.png',
                              late,
                              newSetStateTable,
                              isSelectedSection),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
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
                            width: 650,
                            height: 40,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2))
                                ],
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                    width: 0.5),
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              onChanged: (value) {
                                searchTextChanged(value);
                              },
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
                                      fontSize: 12,
                                      color: Color.fromARGB(73, 0, 0, 0)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.transparent)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryButton),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    listTemp.isNotEmpty
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width - 250,
                            height: 380,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                tableAttendance(
                                    listTemp), // Truyen listData vao
                                const SizedBox(height: 20),
                                showPage(listTemp),
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: Opacity(
                                  opacity: 0.3,
                                  child:
                                      Image.asset('assets/images/nodata.png'),
                                ),
                              ),
                              const SizedBox(height: 10),
                              CustomText(
                                  message: 'No Student Record',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.primaryText.withOpacity(0.3))
                            ],
                          )),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Table tableAttendance(List<AttendanceData> studentAttendance) {
    int startIndex = currentPage * studentsPerPage;
    int endIndex =
        min((currentPage + 1) * studentsPerPage, studentAttendance.length);
    print('---${studentAttendance.first.dateAttendanced}');
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
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
        for (int i = startIndex; i < endIndex; i++)
          TableRow(
            children: [
              TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.white,
                  child: Center(
                    child: CustomText(
                        message: '${i + 1}',
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
                        message: studentAttendance[i].studentID,
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
                        message: studentAttendance[i].studentName,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  color: chooseColor(
                      getResult(studentAttendance[i].result.toString())),
                  child: Center(
                    child: CustomText(
                        message:
                            getResult(studentAttendance[i].result.toString()),
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
                        message:
                            formatTime(studentAttendance[i].dateAttendanced),
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
                      child: const Text('Edit',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryButton,
                              decorationColor: AppColors.primaryButton,
                              decoration: TextDecoration.underline)),
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
                        message: studentAttendance[i].note,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget showPage(List<AttendanceData> studentAttendance) {
    int startIndex = currentPage * studentsPerPage;
    int endIndex = (currentPage + 1) * studentsPerPage;
    if (endIndex > studentAttendance.length) {
      endIndex = studentAttendance.length;
    }

    return Row(
      children: [
        CustomText(
          message:
              'Show ${startIndex + 1} - $endIndex of ${studentAttendance.length} results',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              currentPage > 0 ? Colors.white : Colors.white,
            ),
          ),
          onPressed: currentPage > 0
              ? () {
                  setState(() {
                    currentPage--;
                  });
                }
              : null,
          child: Text(
            'Previous',
            style: TextStyle(
              fontSize: 12,
              color: currentPage > 0 ? const Color(0xff2d71b1) : Colors.grey,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        CustomText(
            message:
                '${currentPage + 1}/${(studentAttendance.length / studentsPerPage).ceil()}',
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.primaryText),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              currentPage <
                      (studentAttendance.length / studentsPerPage).ceil() - 1
                  ? Colors.white
                  : Colors.white,
            ),
          ),
          onPressed: currentPage <
                  (studentAttendance.length / studentsPerPage).ceil() - 1
              ? () {
                  setState(() {
                    currentPage++;
                  });
                }
              : null,
          child: Text(
            'Next',
            style: TextStyle(
              fontSize: 12,
              color: currentPage <
                      (studentAttendance.length / studentsPerPage).ceil() - 1
                  ? const Color(0xff2d71b1)
                  : Colors.grey,
            ),
          ),
        ),
      ],
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

  String getResult(String result) {
    if (result == '1') {
      return 'Present';
    } else if (result == '0.5') {
      return 'Late';
    } else {
      return 'Absent';
    }
  }

  Widget customBoxInformation(String title, String imagePath, int count,
      Function(String title) function, String isSelectedSection) {
    return InkWell(
      onTap: () {
        function(title);
      },
      mouseCursor: SystemMouseCursors.click,
      child: Container(
        width: 200,
        height: 91,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: const [
              BoxShadow(
                  color: AppColors.secondaryText,
                  blurRadius: 2,
                  offset: Offset(0, 2))
            ],
            border: Border.all(
                color: title == isSelectedSection
                    ? AppColors.primaryButton
                    : Colors.white)),
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
                  CustomText(
                      message: '$count',
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

  String formatTime(String time) {
    if (time != '') {
      DateTime serverDateTime = DateTime.parse(time).toLocal();
      String formattedTime = DateFormat("HH:mm:ss a").format(serverDateTime);
      return formattedTime;
    }
    return '';
  }

  Widget header(SocketServerProvider socketServerProvider) {
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
                      socketServerProvider.disconnectSocketServer();
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
              color: nameButton == 'Export'
                  ? Colors.white
                  : AppColors.primaryText),
        ),
      ),
    );
  }
}
