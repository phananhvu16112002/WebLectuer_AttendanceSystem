import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceModel.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/StudentClasses.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/studentClasses_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/CreateAttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/FormPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/RealtimeCheckAttendance.dart';

import 'package:weblectuer_attendancesystem_nodejs/screens/Home/NotificationPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/ReportPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';

class DetailPageTest extends StatefulWidget {
  const DetailPageTest({
    super.key,
  });

  @override
  State<DetailPageTest> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPageTest> {
  TextEditingController searchController = TextEditingController();
  bool checkHome = true;
  bool checkNotification = false;
  bool checkReport = false;
  bool checkForm = false;
  bool checkAttendanceForm = false;
  bool checkViewAttendance = false;
  OverlayEntry? overlayEntry;
  TextEditingController searchInDashboardController = TextEditingController();
  bool formCreated = false;
  bool isCollapsedOpen = true;
  ScrollController scrollController = ScrollController();
  List<StudentClasses> passListData = [];
  List<StudentClasses> banListData = [];
  List<StudentClasses> warningListData = [];
  List<StudentClasses> listData = [];
  List<StudentClasses> listTemp = [];
  List<StudentClasses> searchResult = [];
  String isSelectedSection = 'All';

  int numberAllStudent = 0;
  int numberPassStudent = 0;
  int numberBanStudent = 0;
  int numberWarningStudent = 0;
  int currentPage = 0;
  int itemsPerPage = 10;
  int itemsRecent = 0;
  int lengthList = 0;

  late Future<AttendanceDetailResponseStudent> fetchData;

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
  void initState() {
    super.initState();
    _fetchData();
    print('InitState-----');
  }

  void _fetchData() async {
    fetchData = API(context)
        .getStudentClassAttendanceDetail(); // get Student from class
    fetchData.then((value) {
      setState(() {
        listData = value.data;
        listTemp = value.data;
        numberAllStudent = value.stats.all;
        numberPassStudent = value.stats.pass;
        numberBanStudent = value.stats.ban;
        numberWarningStudent = value.stats.warning;
      });
    });
    print('FetchData-----');
  }

  void newAllListData() {
    setState(() {
      listTemp = listData;
      isSelectedSection = 'All';
      currentPage = 0;
    });
  }

  void newPassListData() {
    if (passListData.isEmpty || passListData.length == 0) {
      for (var studentClasses in listData) {
        if (studentClasses.status.contains('Pass') ||
            studentClasses.status == 'Pass') {
          passListData.add(studentClasses);
        }
      }
    }
    setState(() {
      listTemp = passListData;
      isSelectedSection = 'Pass';
      currentPage = 0;
    });
  }

  void newBanListData() {
    if (banListData.isEmpty || banListData.length == 0) {
      for (var studentClasses in listData) {
        if (studentClasses.status.contains('Ban') ||
            studentClasses.status == 'Ban') {
          banListData.add(studentClasses);
        }
      }
    }
    setState(() {
      listTemp = banListData;
      isSelectedSection = 'Ban';
      currentPage = 0;
    });
  }

  void newWarningListData() {
    if (warningListData.isEmpty || warningListData.length == 0) {
      for (var studentClasses in listData) {
        if (studentClasses.status.contains('Warning') ||
            studentClasses.status == 'Warning') {
          warningListData.add(studentClasses);
        }
      }
    }
    setState(() {
      listTemp = warningListData;
      isSelectedSection = 'Warning';
      currentPage = 0;
    });
  }

  void newSetStateTable(String title) {
    if (title == 'All' || title.contains('All')) {
      newAllListData();
    } else if (title == 'Pass' || title.contains(('Pass'))) {
      newPassListData();
    } else if (title == 'Ban' || title.contains('Ban')) {
      newBanListData();
    } else if (title == 'Warning' || title.contains('Warning')) {
      newWarningListData();
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
    List<StudentClasses> temp = listDataSearch(isSelectedSection);
    for (var element in temp) {
      if (element.student.studentName.contains(query) ||
          element.student.studentName.toLowerCase().trim() ==
              query.toLowerCase().trim() ||
          element.student.studentID.toLowerCase().trim() ==
              query.toLowerCase().trim() ||
          element.student.studentID.contains(query)) {
        searchResult.add(element);
      }
    }
    print('----SearchResult: $searchResult');
    setState(() {
      listTemp = searchResult;
      //currentPage = 0; nen kiem tra lai
    });
  }

  List<StudentClasses> listDataSearch(String section) {
    if (section == 'All') {
      return listData;
    } else if (section == 'Pass') {
      return passListData;
    } else if (section == 'Ban') {
      return banListData;
    } else if (section == 'Warning') {
      return warningListData;
    } else {
      return listData;
    }
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   print('OnDidChangeDependencies');
  // }

  @override
  Widget build(BuildContext context) {
    final studentClassesDataProvider =
        Provider.of<StudentClassesDataProvider>(context, listen: false);
    int numberOfWeeks = 20; // course through provider
    List<TableColumnWidth> listColumnWidths = [
      const FixedColumnWidth(10),
      const FixedColumnWidth(80),
      const IntrinsicColumnWidth(),
    ];
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
                  numberOfWeeks,
                  listColumnWidths,
                  studentClassesDataProvider,
                  listTemp,
                  searchTextChanged,
                  newSetStateTable,
                  isSelectedSection),
            ),
          ],
        ),
      ),
    );
  }

  //AppBar-------------------------------------------
  PreferredSizeWidget appBar() {
    return AppBar(
      leading: null,
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
                    onChanged: (value) {},
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
          checkViewAttendance = false;
          if (title == 'Home') {
            checkHome = true;
            checkAttendanceForm = false;
            checkViewAttendance = false;
          } else if (title == 'Notifications') {
            checkNotification = true;
            checkAttendanceForm = false;
            checkViewAttendance = false;
          } else if (title == 'Reports') {
            checkReport = true;
            checkAttendanceForm = false;
            checkViewAttendance = false;
          } else if (title == 'Forms') {
            checkForm = true;
            checkAttendanceForm = false;
            checkViewAttendance = false;
          } else {
            checkHome = true;
            checkAttendanceForm = false;
            checkViewAttendance = false;
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
      int numberOfWeeks,
      dynamic listColumnWidth,
      StudentClassesDataProvider studentClassesDataProvider,
      List<StudentClasses> listData,
      Function(String querySearch) functionSearch,
      Function(String title) newSetStateTable,
      String isSelectedSection) {
    if (checkHome) {
      return containerHome(
          numberOfWeeks,
          listColumnWidth,
          studentClassesDataProvider,
          listData,
          functionSearch,
          newSetStateTable,
          isSelectedSection);
      // return EditAttendanceDetail();
    } else if (checkNotification) {
      return const NotificationPage();
    } else if (checkReport) {
      return const ReportPage();
    } else if (checkForm) {
      // return const FormPage();
      return Container();
    } else if (checkAttendanceForm) {
      // return const CreateAttendanceFormPage();
      return Container();
    } else if (checkViewAttendance) {
      // return const RealtimeCheckAttendance();
      return Container();
    } else {
      return containerHome(
          numberOfWeeks,
          listColumnWidth,
          studentClassesDataProvider,
          listData,
          functionSearch,
          newSetStateTable,
          isSelectedSection);
    }
  }
  //SideBar------------------------------------------------
  //auto tao cot truoc(success), sau do cho chay 1 vong lap for chay trong tablerow, table cell
  //Main---------------------------------------------------

  Widget containerHome(
      int numberOfWeeks,
      dynamic listColumnWidth,
      StudentClassesDataProvider studentClassesDataProvider,
      List<StudentClasses>? listData,
      Function(String querySearch) functionSearch,
      Function(String title) newSetStateTable,
      String isSelectedSection) {
    return listData!.isNotEmpty
        ? Container(
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
                    color: AppColors.primaryText,
                  ),
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
                            numberAllStudent,
                            newSetStateTable,
                            isSelectedSection),
                        customBoxInformation(
                            'Pass',
                            'assets/icons/present.png',
                            numberPassStudent,
                            newSetStateTable,
                            isSelectedSection),
                        customBoxInformation(
                            'Ban',
                            'assets/icons/absent.png',
                            numberBanStudent,
                            newSetStateTable,
                            isSelectedSection),
                        customBoxInformation(
                            'Warning',
                            'assets/icons/pending.png',
                            numberWarningStudent,
                            newSetStateTable,
                            isSelectedSection),
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                offset: const Offset(0, 2),
                              ),
                            ],
                            border: Border.all(
                              color: const Color.fromRGBO(0, 0, 0, 1)
                                  .withOpacity(0.2),
                              width: 0.5,
                            ),
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              functionSearch(value);
                            },
                            readOnly: false,
                            controller: searchInDashboardController,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
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
                                color: Color.fromARGB(73, 0, 0, 0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.primaryButton),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomButton(
                            buttonName: 'View Attendance',
                            backgroundColorButton: const Color(0xff2d71b1),
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                            function: () {
                              setState(() {
                                checkViewAttendance = true;
                                checkHome = false;
                                checkNotification = false;
                                checkReport = false;
                                checkForm = false;
                                checkAttendanceForm = false;
                              });
                            },
                            height: 50,
                            width: 150,
                            fontSize: 12,
                            colorShadow: Colors.white,
                            borderRadius: 8)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  tableStudent(listColumnWidth, numberOfWeeks, listData),
                ],
              ),
            ),
          )
        : Container(
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
                    color: AppColors.primaryText,
                  ),
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
                            numberAllStudent,
                            newSetStateTable,
                            isSelectedSection),
                        customBoxInformation(
                            'Pass',
                            'assets/icons/present.png',
                            numberPassStudent,
                            newSetStateTable,
                            isSelectedSection),
                        customBoxInformation(
                            'Ban',
                            'assets/icons/absent.png',
                            numberBanStudent,
                            newSetStateTable,
                            isSelectedSection),
                        customBoxInformation(
                            'Warning',
                            'assets/icons/pending.png',
                            numberWarningStudent,
                            newSetStateTable,
                            isSelectedSection),
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
                                offset: const Offset(0, 2),
                              ),
                            ],
                            border: Border.all(
                              color: const Color.fromRGBO(0, 0, 0, 1)
                                  .withOpacity(0.2),
                              width: 0.5,
                            ),
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              functionSearch(value);
                            },
                            readOnly: false,
                            controller: searchInDashboardController,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
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
                                color: Color.fromARGB(73, 0, 0, 0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.primaryButton),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomButton(
                            buttonName: 'View Attendance',
                            backgroundColorButton: const Color(0xff2d71b1),
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                            function: () {
                              setState(() {
                                checkViewAttendance = true;
                                checkHome = false;
                                checkNotification = false;
                                checkReport = false;
                                checkForm = false;
                                checkAttendanceForm = false;
                              });
                            },
                            height: 50,
                            width: 150,
                            fontSize: 12,
                            colorShadow: Colors.white,
                            borderRadius: 8)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  tableStudent(listColumnWidth, numberOfWeeks, listData),
                ],
              ),
            ),
          );
  }

  Widget tableStudent(
      listColumnWidth, int numberOfWeeks, List<StudentClasses> listData) {
    final students = List.generate(
      listData.length,
      (index) => {
        'studentID': ' ${listData[index].student.studentID}',
        'name': ' ${listData[index].student.studentName}',
      },
    );
    List<Map<String, String>> getPaginatedStudents() {
      int startIndex = currentPage * itemsPerPage;
      int endIndex = (currentPage + 1) * itemsPerPage;
      if (endIndex > students.length) endIndex = students.length;
      return students.sublist(startIndex, endIndex);
    }

    List<Map<String, String>> paginatedStudents = getPaginatedStudents();
    itemsRecent = paginatedStudents.length;
    if (currentPage > 0) {
      print('Recent Items: ${itemsRecent + itemsPerPage * (currentPage)}');
    } else {
      print('Item Recent $itemsRecent');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 100,
          height: 300,
          child: listData.isNotEmpty
              ? Row(
                  children: [
                    tableIntro(listColumnWidth, paginatedStudents),
                    tableCheckAttendance(
                        numberOfWeeks, paginatedStudents, listData),
                    tableTotal(paginatedStudents),
                  ],
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
                        child: Image.asset('assets/images/nodata.png'),
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
        ),
        showPage(students)
      ],
    );
  }

  Row showPage(List<Map<String, String>> students) {
    return Row(
      children: [
        CustomText(
          message:
              'Show ${currentPage > 0 ? itemsRecent + itemsPerPage * (currentPage) : itemsRecent} of ${students.length} results',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
        ),
        const SizedBox(
          width: 5,
        ),
        students.isNotEmpty
            ? ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                onPressed: currentPage > 0
                    ? () {
                        setState(() {
                          currentPage--;
                        });
                      }
                    : null,
                child: const Text(
                  'Previous',
                  style: TextStyle(fontSize: 12, color: Color(0xff2d71b1)),
                ),
              )
            : Container(),
        const SizedBox(width: 10),
        students.isNotEmpty
            ? Text(
                '${currentPage + 1}/${(students.length / itemsPerPage).ceil()}',
              )
            : Container(),
        const SizedBox(width: 10),
        students.isNotEmpty
            ? ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                onPressed:
                    currentPage < (students.length / itemsPerPage).ceil() - 1
                        ? () {
                            setState(() {
                              currentPage++;
                            });
                          }
                        : null,
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 12, color: Color(0xff2d71b1)),
                ),
              )
            : Container(),
      ],
    );
  }

  Container tableTotal(List<Map<String, String>> paginatedStudents) {
    return Container(
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
    );
  }

  Expanded tableCheckAttendance(
    int numberOfWeeks,
    List<Map<String, String>> paginatedStudents,
    List<StudentClasses> listData,
  ) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 350,
          child: Table(
            border: TableBorder.all(color: Colors.grey),
            columnWidths: {
              for (int i = 0; i < numberOfWeeks; i++)
                i: FixedColumnWidth(numberOfWeeks <= 13 ? 30 : 60),
            },
            children: [
              TableRow(
                children: List.generate(
                  numberOfWeeks,
                  (j) => TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.grey.withOpacity(0.21),
                      child: Center(
                        child: Tooltip(
                          message: (j < listData.length &&
                                  j < listData[j].attendanceDetail.length)
                              ? formatDate(listData[j]
                                  .attendanceDetail[j]
                                  .dateAttendanced
                                  .toString())
                              : '',
                          child: Text(
                            'Day ${j + 1}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              for (int i = 0; i < paginatedStudents.length; i++)
                TableRow(
                  children: List.generate(
                    numberOfWeeks,
                    (j) => TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            j < listData[i].attendanceDetail.length
                                ? getResult(
                                    listData[i].attendanceDetail[j].result)
                                : '',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(String date) {
    DateTime serverDateTime = DateTime.parse(date).toLocal();
    String formattedDate = DateFormat('MMMM d, y').format(serverDateTime);
    return formattedDate;
  }

  String formatTime(String time) {
    DateTime serverDateTime = DateTime.parse(time).toLocal();
    String formattedTime = DateFormat("HH:mm:ss a").format(serverDateTime);
    return formattedTime;
  }

  String getResult(int result) {
    if (result == 0) {
      return 'Absent';
    } else if (result.toString() == 0.5.toString()) {
      return 'Late';
    } else {
      return 'Present';
    }
  }

  Container tableIntro(
      listColumnWidth, List<Map<String, String>> paginatedStudents) {
    return Container(
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
                color: const Color(0xff1770f0).withOpacity(0.5),
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
                color: const Color(0xff1770f0).withOpacity(0.5),
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
                color: const Color(0xff1770f0).withOpacity(0.5),
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


  // Widget containerHome(
  //     int numberOfWeeks,
  //     dynamic listColumnWidth,
  //     StudentClassesDataProvider studentClassesDataProvider,
  //     List<StudentClasses>? listData,
  //     Function(String querySearch) functionSearch,
  //     Function(String title) newSetStateTable) {
  //   return listData!.isNotEmpty
  //       ? Container(
  //           width: MediaQuery.of(context).size.width - 250,
  //           height: MediaQuery.of(context).size.height,
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   const CustomText(
  //                       message: 'Dashboard',
  //                       fontSize: 25,
  //                       fontWeight: FontWeight.w800,
  //                       color: AppColors.primaryText),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   SizedBox(
  //                     width: MediaQuery.of(context).size.width - 250,
  //                     height: 130,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         customBoxInformation(
  //                             'All',
  //                             'assets/icons/student.png',
  //                             numberAllStudent,
  //                             newSetStateTable),
  //                         customBoxInformation(
  //                             'Pass',
  //                             'assets/icons/present.png',
  //                             numberPassStudent,
  //                             newSetStateTable),
  //                         customBoxInformation('Ban', 'assets/icons/absent.png',
  //                             numberBanStudent, newSetStateTable),
  //                         customBoxInformation(
  //                             'Warning',
  //                             'assets/icons/pending.png',
  //                             numberWarningStudent,
  //                             newSetStateTable),
  //                       ],
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Container(
  //                     width: MediaQuery.of(context).size.width - 250,
  //                     height: 40,
  //                     child: Row(
  //                       children: [
  //                         customButtonDashBoard('Export'),
  //                         customButtonDashBoard('PDF'),
  //                         customButtonDashBoard('Excel'),
  //                         const SizedBox(
  //                           width: 20,
  //                         ),
  //                         Container(
  //                           width: 450,
  //                           height: 40,
  //                           decoration: BoxDecoration(
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                     color: Colors.black.withOpacity(0.1),
  //                                     blurRadius: 4,
  //                                     offset: const Offset(0, 2))
  //                               ],
  //                               border: Border.all(
  //                                   color: const Color.fromRGBO(0, 0, 0, 1)
  //                                       .withOpacity(0.2),
  //                                   width: 0.5),
  //                               color: Colors.white,
  //                               borderRadius:
  //                                   const BorderRadius.all(Radius.circular(5))),
  //                           child: TextFormField(
  //                             onChanged: (value) {
  //                               functionSearch(value);
  //                             },
  //                             readOnly: false,
  //                             controller: searchInDashboardController,
  //                             keyboardType: TextInputType.text,
  //                             style: const TextStyle(
  //                                 color: AppColors.primaryText,
  //                                 fontWeight: FontWeight.normal,
  //                                 fontSize: 15),
  //                             obscureText: false,
  //                             decoration: InputDecoration(
  //                                 contentPadding: const EdgeInsets.all(20),
  //                                 suffixIcon: Icon(
  //                                   Icons.search,
  //                                   color: Colors.black.withOpacity(0.5),
  //                                 ),
  //                                 hintText: 'Search Student',
  //                                 hintStyle: const TextStyle(
  //                                     fontSize: 12,
  //                                     color: Color.fromARGB(73, 0, 0, 0)),
  //                                 enabledBorder: const OutlineInputBorder(
  //                                     borderRadius:
  //                                         BorderRadius.all(Radius.circular(5)),
  //                                     borderSide: BorderSide(
  //                                         width: 1, color: Colors.transparent)),
  //                                 focusedBorder: const OutlineInputBorder(
  //                                   borderRadius:
  //                                       BorderRadius.all(Radius.circular(5)),
  //                                   borderSide: BorderSide(
  //                                       width: 1,
  //                                       color: AppColors.primaryButton),
  //                                 )),
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           width: 20,
  //                         ),
  //                         customWeek('Previous'),
  //                         customWeek('Week 8'),
  //                         customWeek('Next'),
  //                       ],
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   tableStudent(listColumnWidth, numberOfWeeks, listData)
  //                 ]),
  //           ))
  //       : Container(
  //           width: MediaQuery.of(context).size.width - 250,
  //           height: MediaQuery.of(context).size.height,
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   const CustomText(
  //                       message: 'Dashboard',
  //                       fontSize: 25,
  //                       fontWeight: FontWeight.w800,
  //                       color: AppColors.primaryText),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   SizedBox(
  //                     width: MediaQuery.of(context).size.width - 250,
  //                     height: 130,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         customBoxInformation(
  //                             'All',
  //                             'assets/icons/student.png',
  //                             numberAllStudent,
  //                             newSetStateTable),
  //                         customBoxInformation(
  //                             'Pass',
  //                             'assets/icons/present.png',
  //                             numberPassStudent,
  //                             newSetStateTable),
  //                         customBoxInformation('Ban', 'assets/icons/absent.png',
  //                             numberBanStudent, newSetStateTable),
  //                         customBoxInformation(
  //                             'Warning',
  //                             'assets/icons/pending.png',
  //                             numberWarningStudent,
  //                             newSetStateTable),
  //                       ],
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Center(child: Text('Data is not available'))
  //                 ]),
  //           ));
  // }



  
  // Expanded tableCheckAttendance(
  //     int numberOfWeeks,
  //     List<Map<String, String>> paginatedStudents,
  //     List<StudentClasses> listData) {
  //   return Expanded(
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Container(
  //         height: 350,
  //         child: Table(
  //           border: TableBorder.all(color: Colors.grey),
  //           columnWidths: {
  //             for (int i = 0; i < numberOfWeeks; i++)
  //               i: FixedColumnWidth(numberOfWeeks <= 13 ? 30 : 60),
  //           },
  //           children: [
  //             TableRow(children: [
  //               for (int j = 0; j < numberOfWeeks; j++)
  //                 TableCell(
  //                   child: Container(
  //                     padding: const EdgeInsets.all(5),
  //                     color: Colors.grey.withOpacity(0.21),
  //                     child: Center(
  //                       child: Tooltip(
  //                         message: 'null',
  //                         child: Text(
  //                           'Day ${j + 1}',
  //                           style: const TextStyle(
  //                             fontSize: 11,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.black,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //             ]),
  //             for (int i = 0; i < paginatedStudents.length; i++)
  //               TableRow(children: [
  //                 for (int j = 0; j < numberOfWeeks; j++)
  //                   TableCell(
  //                     child: Container(
  //                       padding: const EdgeInsets.all(5),
  //                       color: Colors.white,
  //                       child: Center(
  //                         child: Text(
  //                           j < listData[i].attendanceDetail.length
  //                               ? getResult(
  //                                   listData[i].attendanceDetail[j].result)
  //                               : '',
  //                           style: const TextStyle(
  //                             fontSize: 11,
  //                             fontWeight: FontWeight.normal,
  //                             color: Colors.black,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //               ]),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }