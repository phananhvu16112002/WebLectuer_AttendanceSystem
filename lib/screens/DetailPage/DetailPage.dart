import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/AttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/TestAttendanceDetail.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/class_data_provider.dart';

import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/AfterCreateAttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/CreateAttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/EditAttendanceDetail.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/FormPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/NotificationPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/ReportPage.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
  });

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
  OverlayEntry? overlayEntry;
  TextEditingController searchInDashboardController = TextEditingController();
  bool formCreated = false;
  bool isCollapsedOpen = true;
  ScrollController scrollController = ScrollController();

  final List<Map<String, String>> students = List.generate(
    100,
    (index) => {'studentID': 'ID ${index + 1}', 'name': 'Student ${index + 1}'},
  );

  int currentPage = 0;
  int itemsPerPage = 10;

  List<Map<String, String>> getPaginatedStudents() {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = (currentPage + 1) * itemsPerPage;
    if (endIndex > students.length) endIndex = students.length;
    return students.sublist(startIndex, endIndex);
  }

  void toggleDrawer() {
    setState(() {
      isCollapsedOpen = !isCollapsedOpen;
    });
  }

  void setFormCreated(bool value) {
    setState(() {
      formCreated = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    int numberOfWeeks = 20;

    List<TableColumnWidth> listColumnWidths = [
      const FixedColumnWidth(10),
      const FixedColumnWidth(80),
      const IntrinsicColumnWidth(),
    ];
    List<Map<String, String>> paginatedStudents = getPaginatedStudents();

    // Tạo các cột tuần
    for (int i = 0; i < numberOfWeeks; i++) {
      listColumnWidths.add(const FlexColumnWidth(2));
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isCollapsedOpen ? 250 : 70,
              child: isCollapsedOpen ? leftHeader() : collapsedSideBar(),
            ),
            Expanded(
              child: selectedPage(
                  numberOfWeeks, listColumnWidths, paginatedStudents),
            ),
          ],
        ),
      ),
    );
  }

  //AppBar-------------------------------------------
  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: AppColors.colorHeader,
      flexibleSpace: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                    onPressed: () {
                      toggleDrawer();
                    },
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
  //AppBar-------------------------------------------------

  //SideBar------------------------------------------------
  Widget collapsedSideBar() {
    return Container(
      width: 80,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                checkHome = true;
                checkNotification = false;
                checkReport = false;
                checkForm = false;
              });
            },
            child:
                iconCollapseSideBar(const Icon(Icons.home_outlined), checkHome),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                checkHome = false;
                checkNotification = true;
                checkReport = false;
                checkForm = false;
              });
            },
            child: iconCollapseSideBar(
              const Icon(Icons.notifications_outlined),
              checkNotification,
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                checkHome = false;
                checkNotification = false;
                checkReport = true;
                checkForm = false;
              });
            },
            child: iconCollapseSideBar(
                const Icon(Icons.book_outlined), checkReport),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                checkHome = false;
                checkNotification = false;
                checkReport = false;
                checkForm = true;
              });
            },
            child: iconCollapseSideBar(
              const Icon(Icons.cloud_download_outlined),
              checkForm,
            ),
          ),
        ],
      ),
    );
  }

  Container iconCollapseSideBar(Icon icon, bool check) {
    return Container(
        width: 50,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.white),
            color: check
                ? AppColors.colorHeader.withOpacity(0.5)
                : Colors.transparent),
        child: icon);
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

  Widget selectedPage(
      int numberOfWeeks, dynamic listColumnWidth, dynamic paginated) {
    if (checkHome) {
      return containerHome(numberOfWeeks, listColumnWidth, paginated);
    } else if (checkNotification) {
      return const NotificationPage();
    } else if (checkReport) {
      return const ReportPage();
    } else if (checkForm) {
      return const FormPage();
    } else if (checkAttendanceForm) {
      return const CreateAttendanceFormPage();
    } else {
      return containerHome(numberOfWeeks, listColumnWidth, paginated);
    }
  }
  //SideBar------------------------------------------------
  //auto tao cot truoc(success), sau do cho chay 1 vong lap for chay trong tablerow, table cell
  //Main---------------------------------------------------

  Container containerHome(
      int numberOfWeeks, dynamic listColumnWidth, dynamic paginatedStudents) {
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
                  customBoxInformation('Pass', 'assets/icons/present.png'),
                  customBoxInformation('Ban', 'assets/icons/absent.png'),
                  customBoxInformation('Warning', 'assets/icons/pending.png'),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 300,
                  child: Row(
                    children: [
                      Container(
                        width: 350,
                        height: 350,
                        child: Table(
                          columnWidths: {
                            for (var index in listColumnWidth.asMap().keys)
                              index: listColumnWidth[index]
                          },
                          border: TableBorder.all(color: Colors.grey),
                          children: [
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  color:
                                      const Color(0xff1770f0).withOpacity(0.5),
                                  child: const Center(
                                    child: Text(
                                      'STT',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  color:
                                      const Color(0xff1770f0).withOpacity(0.5),
                                  child: const Center(
                                    child: Text(
                                      'StudentID',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  color:
                                      const Color(0xff1770f0).withOpacity(0.5),
                                  child: const Center(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                            for (int i = 0; i < paginatedStudents.length; i++)
                              TableRow(children: [
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        '${currentPage * itemsPerPage + i + 1}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        '${paginatedStudents[i]['studentID']}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        '${paginatedStudents[i]['name']}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ])
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: 350,
                            child: Table(
                              border: TableBorder.all(color: Colors.grey),
                              columnWidths: {
                                for (int i = 0; i < numberOfWeeks; i++)
                                  i: FixedColumnWidth(
                                      numberOfWeeks <= 13 ? 30 : 60),
                              },
                              children: [
                                TableRow(children: [
                                  for (int i = 0; i < numberOfWeeks; i++)
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        color: Colors.grey.withOpacity(0.21),
                                        child: Center(
                                          child: Text(
                                            'Week ${i + 1}',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ]),
                                for (int i = 0;
                                    i < paginatedStudents.length;
                                    i++)
                                  TableRow(children: [
                                    for (int i = 0; i < numberOfWeeks; i++)
                                      TableCell(
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          color: Colors.white,
                                          child: const Center(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 350,
                        child: Table(
                          border: TableBorder.all(color: Colors.grey),
                          children: [
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  color: Colors.grey.withOpacity(0.21),
                                  child: const Center(
                                    child: Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            for (int i = 0; i < paginatedStudents.length; i++)
                              TableRow(children: [
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    color: Colors.white,
                                    child: const Center(
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ])
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: currentPage > 0
                          ? () {
                              setState(() {
                                currentPage--;
                              });
                            }
                          : null,
                      child: const Text(
                        'Previous',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff2d71b1)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                        '${currentPage + 1}/${(students.length / itemsPerPage).ceil()}'),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: currentPage <
                              (students.length / itemsPerPage).ceil() - 1
                          ? () {
                              setState(() {
                                currentPage++;
                              });
                            }
                          : null,
                      child: const Text(
                        'Next',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff2d71b1)),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
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


  //Main---------------------------------------------------

            // Container(
            //   width: MediaQuery.of(context).size.width - 100,
            //   height: 380,
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 350,
            //         height: 380,
            //         child: Table(
            //           columnWidths: {
            //             for (var index in listColumnWidth.asMap().keys)
            //               index: listColumnWidth[index]
            //           },
            //           border: TableBorder.all(color: Colors.grey),
            //           children: [
            //             TableRow(children: [
            //               TableCell(
            //                 child: Container(
            //                   padding: const EdgeInsets.all(5),
            //                   color: const Color(0xff1770f0).withOpacity(0.5),
            //                   child: const Center(
            //                     child: Text(
            //                       'STT',
            //                       style: TextStyle(
            //                         fontSize: 11,
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.black,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               TableCell(
            //                 child: Container(
            //                   padding: const EdgeInsets.all(5),
            //                   color: const Color(0xff1770f0).withOpacity(0.5),
            //                   child: const Center(
            //                     child: Text(
            //                       'StudentID',
            //                       style: TextStyle(
            //                         fontSize: 11,
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.black,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               TableCell(
            //                 child: Container(
            //                   padding: const EdgeInsets.all(5),
            //                   color: const Color(0xff1770f0).withOpacity(0.5),
            //                   child: const Center(
            //                     child: Text(
            //                       'Name',
            //                       style: TextStyle(
            //                         fontSize: 11,
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.black,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               )
            //             ]),
            //             for (int i = 0; i < students.length; i++)
            //               TableRow(children: [
            //                 TableCell(
            //                   child: Container(
            //                     padding: const EdgeInsets.all(5),
            //                     color: Colors.white,
            //                     child: Center(
            //                       child: Text(
            //                         '${i + 1}',
            //                         style: const TextStyle(
            //                           fontSize: 11,
            //                           fontWeight: FontWeight.bold,
            //                           color: Colors.black,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 TableCell(
            //                   child: Container(
            //                     padding: const EdgeInsets.all(5),
            //                     color: Colors.white,
            //                     child: Center(
            //                       child: Text(
            //                         '${students[i]['studentID']}',
            //                         style: const TextStyle(
            //                           fontSize: 11,
            //                           fontWeight: FontWeight.bold,
            //                           color: Colors.black,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 TableCell(
            //                   child: Container(
            //                     padding: const EdgeInsets.all(5),
            //                     color: Colors.white,
            //                     child: Center(
            //                       child: Text(
            //                         '${students[i]['name']}',
            //                         style: const TextStyle(
            //                           fontSize: 11,
            //                           fontWeight: FontWeight.bold,
            //                           color: Colors.black,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ])
            //           ],
            //         ),
            //       ),
            //       // const SizedBox(width: 0.01,),
            //       Expanded(
            //         child: SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: Expanded(
            //             child: Table(
            //               border: TableBorder.all(color: Colors.grey),
            //               columnWidths: {
            //                 for (int i = 0; i < numberOfWeeks; i++)
            //                   i: FixedColumnWidth(
            //                       numberOfWeeks <= 13 ? 30 : 60),
            //               },
            //               children: [
            //                 TableRow(children: [
            //                   for (int i = 0; i < numberOfWeeks; i++)
            //                     TableCell(
            //                       child: Container(
            //                         padding: const EdgeInsets.all(5),
            //                         color: Colors.grey.withOpacity(0.21),
            //                         child: Center(
            //                           child: Text(
            //                             'Week ${i + 1}',
            //                             style: const TextStyle(
            //                               fontSize: 11,
            //                               fontWeight: FontWeight.bold,
            //                               color: Colors.black,
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                 ]),
            //                 for (int i = 0; i < students.length; i++)
            //                   TableRow(children: [
            //                     for (int i = 0; i < numberOfWeeks; i++)
            //                       TableCell(
            //                         child: Container(
            //                           padding: const EdgeInsets.all(5),
            //                           color: Colors.white,
            //                           child: const Center(
            //                             child: Text(
            //                               '',
            //                               style: TextStyle(
            //                                 fontSize: 11,
            //                                 fontWeight: FontWeight.bold,
            //                                 color: Colors.black,
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                   ]),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         width: 100,
            //         height: 380,
            //         child: Table(
            //           border: TableBorder.all(color: Colors.grey),
            //           children: [
            //             TableRow(children: [
            //               TableCell(
            //                 child: Container(
            //                   padding: const EdgeInsets.all(5),
            //                   color: Colors.grey.withOpacity(0.21),
            //                   child: const Center(
            //                     child: Text(
            //                       'Total',
            //                       style: TextStyle(
            //                         fontSize: 11,
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.black,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ]),
            //             for (int i = 0; i < students.length; i++)
            //               TableRow(children: [
            //                 TableCell(
            //                   child: Container(
            //                     padding: const EdgeInsets.all(5),
            //                     color: Colors.white,
            //                     child: const Center(
            //                       child: Text(
            //                         '',
            //                         style: TextStyle(
            //                           fontSize: 11,
            //                           fontWeight: FontWeight.bold,
            //                           color: Colors.black,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ])
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

// SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width - 250,
//                           height: 380,
//                           child: Table(
//                             columnWidths: {
//                               for (var index in listColumnWidth.asMap().keys)
//                                 index: listColumnWidth[index]
//                             },
//                             border: TableBorder.all(color: Colors.grey),
//                             children: [
//                               TableRow(
//                                 children: [
//                                   TableCell(
//                                     child: Container(
//                                       padding: const EdgeInsets.all(5),
//                                       color: const Color(0xff1770f0)
//                                           .withOpacity(0.5),
//                                       child: const Center(
//                                         child: Text(
//                                           'STT',
//                                           style: TextStyle(
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   TableCell(
//                                     child: Container(
//                                       color: const Color(0xff1770f0)
//                                           .withOpacity(0.5),
//                                       padding: const EdgeInsets.all(5),
//                                       child: const Center(
//                                         child: Text(
//                                           'StudentID',
//                                           style: TextStyle(
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   TableCell(
//                                     child: Container(
//                                       padding: const EdgeInsets.all(5),
//                                       color: const Color(0xff1770f0)
//                                           .withOpacity(0.5),
//                                       child: const Center(
//                                         child: Text(
//                                           'Name',
//                                           style: TextStyle(
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   for (int i = 0; i < numberOfWeeks; i++)
//                                     TableCell(
//                                       child: Container(
//                                         padding: const EdgeInsets.all(5),
//                                         color: Colors.grey.withOpacity(0.21),
//                                         child: Center(
//                                           child: Text(
//                                             'Week ${i + 1}',
//                                             style: const TextStyle(
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                               for (var i = 0; i < students.length; i++)
//                                 TableRow(
//                                   children: [
//                                     TableCell(
//                                       child: Container(
//                                         padding: const EdgeInsets.all(5),
//                                         color: Colors.white,
//                                         child: Center(
//                                           child: Text(
//                                             '${i + 1}',
//                                             style: const TextStyle(
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Container(
//                                         color: Colors.white,
//                                         padding: const EdgeInsets.all(5),
//                                         child: Center(
//                                           child: Text(
//                                             '${students[i]['studentID']}',
//                                             style: const TextStyle(
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Container(
//                                         padding: const EdgeInsets.all(5),
//                                         color: Colors.white,
//                                         child: Center(
//                                           child: Text(
//                                             '${students[i]['name']}',
//                                             style: const TextStyle(
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     for (int i = 0; i < numberOfWeeks; i++)
//                                       TableCell(
//                                         child: Container(
//                                           padding: const EdgeInsets.all(5),
//                                           color: Colors.white.withOpacity(0.21),
//                                           child: const Center(
//                                             child: Text(
//                                               '',
//                                               style: TextStyle(
//                                                 fontSize: 11,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),