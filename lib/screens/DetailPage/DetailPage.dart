import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/main.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/DetailPage/ClassModel.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/DetailPage/StudentData.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/attendanceForm_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/edit_attendance_detail_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/selected_page_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/socketServer_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/studentClasses_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/teacher_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/WelcomePage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/CreateAttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/EditAttendanceDetail.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/FormPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/RealtimeCheckAttendance.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/chart_class_screen.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/edit_attendance_form.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/widgets/app_bar_mobile_detail_page.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/HomePage.dart';

import 'package:weblectuer_attendancesystem_nodejs/screens/Home/NotificationPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/ReportPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/Test/ReportPage1.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';
import 'package:excel/excel.dart' as excel;
import 'package:weblectuer_attendancesystem_nodejs/services/Responsive.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.classes,
  });

  final Class? classes;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController searchController = TextEditingController();
  bool checkHome = true;
  // bool checkNotification = false;
  // bool checkReport = false;
  bool checkForm = false;
  bool checkAttendanceForm = false;
  bool checkViewAttendance = false;
  OverlayEntry? overlayEntry;
  TextEditingController searchInDashboardController = TextEditingController();
  bool formCreated = false;
  bool isCollapsedOpen = true;
  ScrollController scrollController = ScrollController();
  List<StudentData> passListData = [];
  List<StudentData> banListData = [];
  List<StudentData> warningListData = [];
  List<StudentData> listData = [];
  List<StudentData> listTemp = [];
  List<StudentData> searchResult = [];
  String isSelectedSection = 'All';

  int numberAllStudent = 0;
  int numberPassStudent = 0;
  int numberBanStudent = 0;
  int numberWarningStudent = 0;
  int currentPage = 0;
  int itemsPerPage = 10;
  int itemsRecent = 0;
  int lengthList = 0;
  int numberOfWeeks = 0;

  late Future<ClassModel?> fetchData;
  late Class classes;

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
    classes = widget.classes!;
    _fetchData();
    print("-------------------------------------");
    print("socker is connect to server");
    Future.delayed(Duration.zero, () {
      var socketServerProvider =
          Provider.of<SocketServerProvider>(context, listen: false);
      socketServerProvider.connectToSocketServer(classes.classID);
    });
  }

  void _fetchData() async {
    fetchData = API(context).getStudentsWithAllAttendanceDetails(
        classes.classID!); // get Student from class
    fetchData.then((value) {
      setState(() {
        listData = value?.data ?? [];
        listTemp = value?.data ?? [];
        numberAllStudent = value?.classData.total ?? 0;
        numberPassStudent = value?.classData.pass ?? 0;
        numberBanStudent = value?.classData.ban ?? 0;
        numberWarningStudent = value?.classData.warning ?? 0;
        numberOfWeeks = value?.classData.totalWeeks ?? 0;
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
    if (passListData.isEmpty || passListData.isEmpty) {
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
    if (banListData.isEmpty || banListData.isEmpty) {
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
    if (warningListData.isEmpty || warningListData.isEmpty) {
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
    List<StudentData> temp = listDataSearch(isSelectedSection);
    for (var element in temp) {
      if (element.studentName.contains(query) ||
          element.studentName.toLowerCase().trim() ==
              query.toLowerCase().trim() ||
          element.studentID.toLowerCase().trim() ==
              query.toLowerCase().trim() ||
          element.studentID.contains(query)) {
        searchResult.add(element);
      }
    }
    print('----SearchResult: $searchResult');
    setState(() {
      listTemp = searchResult;
      //currentPage = 0; nen kiem tra lai
    });
  }

  List<StudentData> listDataSearch(String section) {
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

  @override
  Widget build(BuildContext context) {
    print('Detail Page');
    final studentClassesDataProvider =
        Provider.of<StudentClassesDataProvider>(context, listen: false);
    final socketServerProvider =
        Provider.of<SocketServerProvider>(context, listen: false);
    final attendanceFormProvider =
        Provider.of<AttendanceFormDataProvider>(context, listen: false);
    final teacherDataProvider =
        Provider.of<TeacherDataProvider>(context, listen: false);
    final selectedPageProvider = Provider.of<SelectedPageProvider>(context);
    final editAttendanceDetailProvider =
        Provider.of<EditAttendanceDetailProvider>(context);
    List<TableColumnWidth> listColumnWidths = [
      const FixedColumnWidth(10),
      const FixedColumnWidth(80),
      const IntrinsicColumnWidth(),
    ];
    for (int i = 0; i < numberOfWeeks; i++) {
      listColumnWidths.add(const FlexColumnWidth(2));
    }

    List<TableColumnWidth> listColumnWidthsMobile = [
      const FixedColumnWidth(25),
      const FixedColumnWidth(63),
      const IntrinsicColumnWidth(),
    ];
    for (int i = 0; i < numberOfWeeks; i++) {
      listColumnWidthsMobile.add(const FlexColumnWidth(2));
    }
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        selectedPageProvider.setCheckAttendanceForm(false);
        selectedPageProvider.setCheckHome(true);
        selectedPageProvider.setCheckNoti(false);
        selectedPageProvider.setCheckReport(false);
        selectedPageProvider.setCheckForm(false);
        selectedPageProvider.setCheckEditAttendanceForm(false);
        selectedPageProvider.setCheckAttendanceDetail(false);
        selectedPageProvider.setCheckChart(false);
        socketServerProvider.disconnectSocketServer();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          leading: const Icon(null),
          backgroundColor: AppColors.colorHeader,
          flexibleSpace: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Responsive(
              mobile: AppBarMobileDetailPage(
                  socketServerProvider: socketServerProvider,
                  context: context,
                  teacherDataProvider: teacherDataProvider),
              tablet: _appbarTablet(socketServerProvider, context, size,
                  teacherDataProvider, selectedPageProvider),
              desktop: _appbarDesktop(socketServerProvider, teacherDataProvider,
                  context, selectedPageProvider),
            ),
          ),
        ),
        body: Responsive(
          mobile: _bodyMobile(
              context,
              size,
              numberOfWeeks,
              listColumnWidthsMobile,
              studentClassesDataProvider,
              attendanceFormProvider,
              selectedPageProvider,
              editAttendanceDetailProvider),
          tablet: _bodyTablet(
              size,
              context,
              numberOfWeeks,
              listColumnWidths,
              studentClassesDataProvider,
              attendanceFormProvider,
              selectedPageProvider,
              editAttendanceDetailProvider),
          desktop: _bodyDesktop(
              context,
              size,
              numberOfWeeks,
              listColumnWidths,
              studentClassesDataProvider,
              attendanceFormProvider,
              selectedPageProvider,
              editAttendanceDetailProvider),
        ),
      ),
    );
  }

  SingleChildScrollView _bodyMobile(
      BuildContext context,
      Size size,
      int numberOfWeeks,
      List<TableColumnWidth> listColumnWidthsMobile,
      StudentClassesDataProvider studentClassesDataProvider,
      AttendanceFormDataProvider attendanceFormProvider,
      SelectedPageProvider selectedPageProvider,
      EditAttendanceDetailProvider editAttendanceDetailProvider) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isCollapsedOpen ? 200 : 60,
            child: isCollapsedOpen
                ? _leftHeader(context, selectedPageProvider)
                : collapsedSideBar(),
          ),
          Expanded(
            flex: size.width <= 1200 ? 6 : 5,
            child: selectedPage(
                numberOfWeeks,
                listColumnWidthsMobile,
                studentClassesDataProvider,
                attendanceFormProvider,
                listTemp,
                searchTextChanged,
                newSetStateTable,
                isSelectedSection,
                size,
                true,
                selectedPageProvider,
                editAttendanceDetailProvider),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _bodyTablet(
      Size size,
      BuildContext context,
      int numberOfWeeks,
      List<TableColumnWidth> listColumnWidths,
      StudentClassesDataProvider studentClassesDataProvider,
      AttendanceFormDataProvider attendanceFormProvider,
      SelectedPageProvider selectedPageProvider,
      EditAttendanceDetailProvider editAttendanceDetailProvider) {
    if (size.width < 1080) {
      setState(() {
        isCollapsedOpen = false;
      });
    } else {
      setState(() {
        isCollapsedOpen = true;
      });
    }
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isCollapsedOpen ? 200 : 60,
            child: isCollapsedOpen
                ? _leftHeader(context, selectedPageProvider)
                : collapsedSideBar(),
          ),
          Expanded(
            flex: size.width <= 1200 ? 6 : 5,
            child: selectedPage(
                numberOfWeeks,
                listColumnWidths,
                studentClassesDataProvider,
                attendanceFormProvider,
                listTemp,
                searchTextChanged,
                newSetStateTable,
                isSelectedSection,
                size,
                false,
                selectedPageProvider,
                editAttendanceDetailProvider),
          ),
        ],
      ),
    );
  }

  Row _appbarTablet(
      SocketServerProvider socketServerProvider,
      BuildContext context,
      Size size,
      TeacherDataProvider teacherDataProvider,
      SelectedPageProvider selectedPageProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                socketServerProvider.disconnectSocketServer();
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const HomePage()));
              },
              mouseCursor: SystemMouseCursors.click,
              child: Image.asset(
                'assets/images/logo.png',
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(width: size.width >= 700 ? 160 : 120),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextField(
              controller: searchController,
              textInputType: TextInputType.text,
              obscureText: false,
              suffixIcon:
                  const IconButton(onPressed: null, icon: Icon(Icons.search)),
              hintText: 'Search',
              prefixIcon: const Icon(null),
              readOnly: false,
              width: 250,
              height: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Container(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                            message: teacherDataProvider.userData.teacherName,
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
        )
      ],
    );
  }

  SingleChildScrollView _bodyDesktop(
      BuildContext context,
      Size size,
      int numberOfWeeks,
      List<TableColumnWidth> listColumnWidths,
      StudentClassesDataProvider studentClassesDataProvider,
      AttendanceFormDataProvider attendanceFormProvider,
      SelectedPageProvider selectedPageProvider,
      EditAttendanceDetailProvider editAttendanceDetailProvider) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isCollapsedOpen ? 250 : 80,
            child: isCollapsedOpen
                ? _leftHeader(context, selectedPageProvider)
                : collapsedSideBar(),
          ),
          Expanded(
            flex: size.width <= 1200 ? 6 : 5,
            child: selectedPage(
                numberOfWeeks,
                listColumnWidths,
                studentClassesDataProvider,
                attendanceFormProvider,
                listTemp,
                searchTextChanged,
                newSetStateTable,
                isSelectedSection,
                size,
                false,
                selectedPageProvider,
                editAttendanceDetailProvider),
          ),
        ],
      ),
    );
  }

  Container _leftHeader(
      BuildContext context, SelectedPageProvider selectedPageProvider) {
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
            // Center(
            //     child: InkWell(
            //   onTap: () {
            //     // setState(() {
            //     // checkHome = false;
            //     // checkNotification = false;
            //     // checkReport = false;
            //     // checkForm = false;
            //     // checkAttendanceForm = true;

            //     selectedPageProvider.setCheckAttendanceForm(true);
            //     selectedPageProvider.setCheckHome(false);
            //     selectedPageProvider.setCheckNoti(false);
            //     selectedPageProvider.setCheckReport(false);
            //     selectedPageProvider.setCheckForm(false);
            //     selectedPageProvider.setCheckEditAttendanceForm(false);
            //     selectedPageProvider.setCheckChart(false);

            //     // });
            //   },
            //   child: Container(
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 15, horizontal: 32),
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           border: Border.all(color: AppColors.primaryText),
            //           borderRadius: BorderRadius.circular(8)),
            //       child: const Center(
            //         child: Text(
            //           textAlign: TextAlign.center,
            //           'Create Attendance Form',
            //           style: TextStyle(
            //               fontSize: 12,
            //               fontWeight: FontWeight.bold,
            //               color: AppColors.primaryText),
            //         ),
            //       )),
            // )),
            // const SizedBox(
            //   height: 5,
            // ),
            const CustomText(
                message: 'Analyze',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryText),
            itemHeader('Dashboard', const Icon(Icons.home_outlined),
                selectedPageProvider.getCheckHome, selectedPageProvider),
            const CustomText(
                message: 'Manage',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryText),
            // itemHeader(
            //     'Notifications',
            //     const Icon(Icons.notifications_outlined),
            //     selectedPageProvider.checkNoti,
            //     selectedPageProvider),
            // itemHeader('Reports', const Icon(Icons.book_outlined),
            //     selectedPageProvider.getCheckReport, selectedPageProvider),
            itemHeader('Forms', const Icon(Icons.edit_document),
                selectedPageProvider.checkForm, selectedPageProvider),
            itemHeader('Charts', const Icon(Icons.bar_chart_rounded),
                selectedPageProvider.checkChart, selectedPageProvider),
          ],
        ),
      ),
    );
  }

  Row _appbarDesktop(
      SocketServerProvider socketServerProvider,
      TeacherDataProvider teacherDataProvider,
      BuildContext context,
      SelectedPageProvider selectedPageProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                selectedPageProvider.setCheckAttendanceForm(false);
                selectedPageProvider.setCheckHome(true);
                selectedPageProvider.setCheckNoti(false);
                selectedPageProvider.setCheckReport(false);
                selectedPageProvider.setCheckForm(false);
                selectedPageProvider.setCheckEditAttendanceForm(false);
                selectedPageProvider.setCheckChart(false);
                socketServerProvider.disconnectSocketServer();
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const HomePage()));
              },
              mouseCursor: SystemMouseCursors.click,
              child: Image.asset(
                'assets/images/logo.png',
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: 180),
            // IconButton(
            //     onPressed: () {
            //       toggleDrawer();
            //     },
            //     icon: const Icon(
            //       Icons.menu,
            //       size: 25,
            //       color: AppColors.textName,
            //     ))
          ],
        ),
        Row(
          children: [
            CustomTextField(
              controller: searchController,
              textInputType: TextInputType.text,
              obscureText: false,
              suffixIcon:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              hintText: 'Search',
              prefixIcon: const Icon(null),
              readOnly: false,
              width: 250,
              height: 50,
            ),
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
                  PopupMenuItem(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const WelcomePage()));
                    },
                    child: const Text("Log Out"),
                  ),
                ],
              ),
              child: Container(
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CustomText(
                        message: teacherDataProvider.userData.teacherName,
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
    );
  }

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
                checkHome = false;
                // checkNotification = false;
                // checkReport = false;
                checkForm = false;
                checkAttendanceForm = true;
              });
            },
            child: iconCollapseSideBar(
                const Icon(Icons.lte_plus_mobiledata), checkHome),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                checkHome = true;
                // checkNotification = false;
                // checkReport = false;
                checkForm = false;
              });
            },
            child:
                iconCollapseSideBar(const Icon(Icons.home_outlined), checkHome),
          ),
          const SizedBox(height: 20),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       checkHome = false;
          //       // checkNotification = true;
          //       // checkReport = false;
          //       checkForm = false;
          //     });
          //   },
          //   child: iconCollapseSideBar(
          //     const Icon(Icons.notifications_outlined),
          //     checkNotification,
          //   ),
          // ),
          const SizedBox(height: 20),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       checkHome = false;
          //       checkNotification = false;
          //       checkReport = true;
          //       checkForm = false;
          //     });
          //   },
          //   child: iconCollapseSideBar(
          //       const Icon(Icons.book_outlined), checkReport),
          // ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                checkHome = false;
                // checkNotification = false;
                // checkReport = false;
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

  Widget itemHeader(String title, Icon icon, bool check,
      SelectedPageProvider selectedPageProvider) {
    return InkWell(
      onTap: () {
        setState(() {
          // checkHome = false;
          // checkNotification = false;
          // checkReport = false;
          // checkForm = false;
          // checkViewAttendance = false;

          selectedPageProvider.setCheckAttendanceForm(false);
          selectedPageProvider.setCheckHome(false);
          selectedPageProvider.setCheckNoti(false);
          selectedPageProvider.setCheckReport(false);
          selectedPageProvider.setCheckForm(false);
          selectedPageProvider.setCheckEditAttendanceForm(false);
          selectedPageProvider.setCheckAttendanceDetail(false);
          selectedPageProvider.setCheckChart(false);

          if (title == 'Home') {
            // checkHome = true;
            // checkAttendanceForm = false;
            // checkViewAttendance = false;
            selectedPageProvider.setCheckAttendanceForm(false);
            selectedPageProvider.setCheckAttendanceDetail(false);
            selectedPageProvider.setCheckHome(true);
          } else if (title == 'Notifications') {
            // checkNotification = true;
            // checkAttendanceForm = false;
            // checkViewAttendance = false;

            selectedPageProvider.setCheckAttendanceForm(false);
            selectedPageProvider.setCheckAttendanceDetail(false);

            selectedPageProvider.setCheckNoti(true);
          } else if (title == 'Reports') {
            // checkReport = true;
            // checkAttendanceForm = false;
            // checkViewAttendance = false;
            selectedPageProvider.setCheckReport(true);
            selectedPageProvider.setCheckAttendanceForm(false);
          } else if (title == 'Forms') {
            // checkForm = true;
            // checkAttendanceForm = false;
            // checkViewAttendance = false;
            selectedPageProvider.setCheckForm(true);
            selectedPageProvider.setCheckAttendanceForm(false);
            selectedPageProvider.setCheckAttendanceDetail(false);
          } else if (title == 'Charts') {
            // checkForm = true;
            // checkAttendanceForm = false;
            // checkViewAttendance = false;
            selectedPageProvider.setCheckChart(true);
            selectedPageProvider.setCheckAttendanceForm(false);
            selectedPageProvider.setCheckAttendanceDetail(false);
          } else {
            selectedPageProvider.setCheckAttendanceForm(false);
            selectedPageProvider.setCheckAttendanceDetail(false);
            selectedPageProvider.setCheckHome(true);
            // checkHome = true;
            // checkAttendanceForm = false;
            // checkViewAttendance = false;
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

  Widget selectedPage(
      int numberOfWeeks,
      dynamic listColumnWidth,
      StudentClassesDataProvider studentClassesDataProvider,
      AttendanceFormDataProvider attendanceFormDataProvider,
      List<StudentData> listData,
      Function(String querySearch) functionSearch,
      Function(String title) newSetStateTable,
      String isSelectedSection,
      Size size,
      bool isMobile,
      SelectedPageProvider selectedPageProvider,
      EditAttendanceDetailProvider editAttendanceDetailProvider) {
    print('selected Page------');
    
    if (selectedPageProvider.getCheckHome) {
      if (isMobile) {
        return homeMobile(
            numberOfWeeks,
            listColumnWidth,
            studentClassesDataProvider,
            attendanceFormDataProvider,
            listData,
            functionSearch,
            newSetStateTable,
            isSelectedSection,
            size,
            selectedPageProvider,
            editAttendanceDetailProvider);
      } else {
        return containerHome(
            numberOfWeeks,
            listColumnWidth,
            studentClassesDataProvider,
            attendanceFormDataProvider,
            listData,
            functionSearch,
            newSetStateTable,
            isSelectedSection,
            size,
            selectedPageProvider,
            editAttendanceDetailProvider);
      }
    } else if (selectedPageProvider.getCheckNoti) {
      return const NotificationPage();
    } else if (selectedPageProvider.getCheckReport) {
      return const ReportPage();
    } else if (selectedPageProvider.getCheckForm) {
      return FormPage(
        classes: classes,
      );
    } else if (selectedPageProvider.getCheckAttendanceForm) {
      return CreateAttendanceFormPage(
        classes: classes,
      ); //test
    } else if (selectedPageProvider.getCheckEditAttendanceForm) {
      return EditAttendanceForm(classes: classes);
    } else if (selectedPageProvider.getCheckAttendanceDetail) {
      return EditAttendanceDetail(
          studentID: editAttendanceDetailProvider.getStudentID,
          formID: editAttendanceDetailProvider.getFormID,
          studentName: editAttendanceDetailProvider.getStudentName,
          classes: classes);
    } else if (selectedPageProvider.getCheckChart) {
      return ChartClassScreen(
        classes: widget.classes,
      );
    } else {
      if (isMobile) {
        return homeMobile(
            numberOfWeeks,
            listColumnWidth,
            studentClassesDataProvider,
            attendanceFormDataProvider,
            listData,
            functionSearch,
            newSetStateTable,
            isSelectedSection,
            size,
            selectedPageProvider,
            editAttendanceDetailProvider);
      } else {
        return containerHome(
            numberOfWeeks,
            listColumnWidth,
            studentClassesDataProvider,
            attendanceFormDataProvider,
            listData,
            functionSearch,
            newSetStateTable,
            isSelectedSection,
            size,
            selectedPageProvider,
            editAttendanceDetailProvider);
      }
    }
  }
  //SideBar------------------------------------------------
  //auto tao cot truoc(success), sau do cho chay 1 vong lap for chay trong tablerow, table cell
  //Main---------------------------------------------------

  Widget containerHome(
      int numberOfWeeks,
      dynamic listColumnWidth,
      StudentClassesDataProvider studentClassesDataProvider,
      AttendanceFormDataProvider attendanceFormDataProvider,
      List<StudentData>? listData,
      Function(String querySearch) functionSearch,
      Function(String title) newSetStateTable,
      String isSelectedSection,
      Size size,
      SelectedPageProvider selectedPageProvider,
      EditAttendanceDetailProvider editAttendanceDetailProvider) {
        // print('err ${listData!.last.attendancedetails}');
        // print('form ${listData!.last.attendancedetails.last.attendanceForm}');
      print('err ${listData == []}');
    return listData != null && listData.isNotEmpty
        ? SizedBox(
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
                  CustomText(
                    message:
                        'Dashboard - ${widget.classes?.course?.courseName ?? ''}',
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    message:
                        'Group: ${widget.classes?.group} - Sub:${widget.classes?.subGroup ?? ''}',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    child: size.width > 900
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              customBoxInformation(
                                  'All',
                                  'assets/icons/student.png',
                                  numberAllStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Pass',
                                  'assets/icons/present.png',
                                  numberPassStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Ban',
                                  'assets/icons/absent.png',
                                  numberBanStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Warning',
                                  'assets/icons/pending.png',
                                  numberWarningStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                            ],
                          )
                        : GridView.count(
                            padding: EdgeInsets.zero,
                            crossAxisCount: 4,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 30 / 20,
                            children: [
                              customBoxInformation(
                                  'All',
                                  'assets/icons/student.png',
                                  numberAllStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Pass',
                                  'assets/icons/present.png',
                                  numberPassStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Ban',
                                  'assets/icons/absent.png',
                                  numberBanStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Warning',
                                  'assets/icons/pending.png',
                                  numberWarningStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customButtonDashBoard('Export', listData,
                            widget.classes?.course?.totalWeeks ?? 0, false),
                        customButtonDashBoard('Excel', listData,
                            widget.classes?.course?.totalWeeks ?? 0, false),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: size.width >= 910 ? 400 : 200,
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
                          width: 15,
                        ),
                        CustomButton(
                            buttonName: 'View Attendance',
                            backgroundColorButton: 
                                listData.last.attendancedetails.isNotEmpty &&
                                        listData.last.attendancedetails.last
                                            .attendanceForm.isNotEmpty 
                                    ? const Color(0xff2d71b1)
                                    : Color(0xff2d71b1).withOpacity(0.5),
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                            function: listData
                                        .last.attendancedetails.isNotEmpty &&
                                    listData.last.attendancedetails.last
                                        .attendanceForm.isNotEmpty
                                        && listData.isNotEmpty
                                ? () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                RealtimeCheckAttendance(
                                                  formID: listData
                                                      .last
                                                      .attendancedetails
                                                      .last
                                                      .attendanceForm,
                                                  classes: listData
                                                      .last
                                                      .attendancedetails
                                                      .last
                                                      .classDetail,
                                                  classesData: widget.classes,
                                                )));
                                  }
                                : null,
                            height: 50,
                            width: size.width <= 1180 ? 130 : 150,
                            fontSize: 12,
                            colorShadow: Colors.white,
                            borderRadius: 8)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  tableStudent(
                      listColumnWidth,
                      numberOfWeeks,
                      listData,
                      size,
                      false,
                      selectedPageProvider,
                      editAttendanceDetailProvider),
                ],
              ),
            ),
          )
        : SizedBox(
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
                   CustomText(
                    message: 'Dashboard - ${widget.classes?.course?.courseName ?? ''}',
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    message:
                        'Group: ${widget.classes?.group} - Sub:${widget.classes?.subGroup ?? ''}',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    child: size.width > 900
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              customBoxInformation(
                                  'All',
                                  'assets/icons/student.png',
                                  numberAllStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Pass',
                                  'assets/icons/present.png',
                                  numberPassStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Ban',
                                  'assets/icons/absent.png',
                                  numberBanStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Warning',
                                  'assets/icons/pending.png',
                                  numberWarningStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                            ],
                          )
                        : GridView.count(
                            padding: EdgeInsets.zero,
                            crossAxisCount: 4,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 30 / 20,
                            children: [
                              customBoxInformation(
                                  'All',
                                  'assets/icons/student.png',
                                  numberAllStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Pass',
                                  'assets/icons/present.png',
                                  numberPassStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Ban',
                                  'assets/icons/absent.png',
                                  numberBanStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                              customBoxInformation(
                                  'Warning',
                                  'assets/icons/pending.png',
                                  numberWarningStudent,
                                  newSetStateTable,
                                  isSelectedSection,
                                  size,
                                  false),
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customButtonDashBoard('Export', listData ?? [],
                            widget.classes?.course?.totalWeeks ?? 0, false),
                        customButtonDashBoard('Excel', listData ?? [],
                            widget.classes?.course?.totalWeeks ?? 0, false),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          RealtimeCheckAttendance(
                                            formID: listData
                                                    ?.last
                                                    .attendancedetails
                                                    .last
                                                    .attendanceForm ??
                                                '',
                                            classes: listData
                                                    ?.last
                                                    .attendancedetails
                                                    .last
                                                    .classDetail ??
                                                '',
                                            classesData: widget.classes,
                                          )));
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
                  tableStudent(
                      listColumnWidth,
                      numberOfWeeks,
                      listData ?? [],
                      size,
                      false,
                      selectedPageProvider,
                      editAttendanceDetailProvider),
                ],
              ),
            ),
          );
  }

  Widget homeMobile(
      int numberOfWeeks,
      dynamic listColumnWidth,
      StudentClassesDataProvider studentClassesDataProvider,
      AttendanceFormDataProvider attendanceFormDataProvider,
      List<StudentData>? listData,
      Function(String querySearch) functionSearch,
      Function(String title) newSetStateTable,
      String isSelectedSection,
      Size size,
      SelectedPageProvider selectedPageProvider,
      EditAttendanceDetailProvider editAttendanceDetailProvider) {
    return listData != null && listData.isNotEmpty
        ? SizedBox(
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
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 12 / 5,
                      children: [
                        customBoxInformation(
                            'All',
                            'assets/icons/student.png',
                            numberAllStudent,
                            newSetStateTable,
                            isSelectedSection,
                            size,
                            true),
                        customBoxInformation(
                            'Pass',
                            'assets/icons/present.png',
                            numberPassStudent,
                            newSetStateTable,
                            isSelectedSection,
                            size,
                            true),
                        customBoxInformation(
                            'Ban',
                            'assets/icons/absent.png',
                            numberBanStudent,
                            newSetStateTable,
                            isSelectedSection,
                            size,
                            true),
                        customBoxInformation(
                            'Warning',
                            'assets/icons/pending.png',
                            numberWarningStudent,
                            newSetStateTable,
                            isSelectedSection,
                            size,
                            true),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customButtonDashBoard('Export', listData,
                            widget.classes?.course?.totalWeeks ?? 0, true),
                        customButtonDashBoard('Excel', listData,
                            widget.classes?.course?.totalWeeks ?? 0, true),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 100,
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
                              fontSize: 12,
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
                          width: 10,
                        ),
                        CustomButton(
                            buttonName: 'View Attendance',
                            backgroundColorButton: const Color(0xff2d71b1),
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          RealtimeCheckAttendance(
                                              formID:
                                                  listData
                                                      .last
                                                      .attendancedetails
                                                      .last
                                                      .attendanceForm,
                                              classes: listData
                                                  .last
                                                  .attendancedetails
                                                  .last
                                                  .classDetail,
                                              classesData: widget.classes)));
                            },
                            height: 40,
                            width: size.width <= 440 ? 80 : 100,
                            fontSize: 8,
                            colorShadow: Colors.white,
                            borderRadius: 8)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  tableStudent(listColumnWidth, numberOfWeeks, listData, size,
                      true, selectedPageProvider, editAttendanceDetailProvider),
                ],
              ),
            ),
          )
        : SizedBox(
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
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 12 / 5,
                      children: [
                        customBoxInformation(
                            'All',
                            'assets/icons/student.png',
                            numberAllStudent,
                            newSetStateTable,
                            isSelectedSection,
                            size,
                            true),
                        customBoxInformation(
                            'Pass',
                            'assets/icons/present.png',
                            numberPassStudent,
                            newSetStateTable,
                            isSelectedSection,
                            size,
                            true),
                        customBoxInformation(
                            'Ban',
                            'assets/icons/absent.png',
                            numberBanStudent,
                            newSetStateTable,
                            isSelectedSection,
                            size,
                            true),
                        customBoxInformation(
                            'Warning',
                            'assets/icons/pending.png',
                            numberWarningStudent,
                            newSetStateTable,
                            isSelectedSection,
                            size,
                            true),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customButtonDashBoard('Export', listData ?? [],
                            widget.classes?.course?.totalWeeks ?? 0, true),
                        customButtonDashBoard('Excel', listData ?? [],
                            widget.classes?.course?.totalWeeks ?? 0, true),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 100,
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
                              fontSize: 12,
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
                          width: 10,
                        ),
                        CustomButton(
                            buttonName: 'View Attendance',
                            backgroundColorButton: const Color(0xff2d71b1),
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          RealtimeCheckAttendance(
                                              formID:
                                                  listData
                                                          ?.last
                                                          .attendancedetails
                                                          .last
                                                          .attendanceForm ??
                                                      '',
                                              classes: listData
                                                      ?.last
                                                      .attendancedetails
                                                      .last
                                                      .classDetail ??
                                                  '',
                                              classesData: widget.classes)));
                            },
                            height: 40,
                            width: size.width <= 440 ? 80 : 100,
                            fontSize: 8,
                            colorShadow: Colors.white,
                            borderRadius: 8)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  tableStudent(
                      listColumnWidth,
                      numberOfWeeks,
                      listData ?? [],
                      size,
                      true,
                      selectedPageProvider,
                      editAttendanceDetailProvider),
                ],
              ),
            ),
          );
  }

  Widget tableStudent(
      listColumnWidth,
      int numberOfWeeks,
      List<StudentData> listData,
      Size size,
      bool isMobile,
      SelectedPageProvider selectedPageProvider,
      EditAttendanceDetailProvider editAttendanceDetailProvider) {
    final students = List.generate(
      listData.length,
      (index) => {
        'studentID': ' ${listData[index].studentID}',
        'name': ' ${listData[index].studentName}',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: listData.isNotEmpty
              ? Column(
                  children: [
                    !isMobile
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: size.width <= 885 ? 4 : 2,
                                child: tableIntro(listColumnWidth,
                                    paginatedStudents, listData, false),
                              ),
                              Expanded(
                                flex: 2,
                                child: tableCheckAttendance(
                                    numberOfWeeks,
                                    paginatedStudents,
                                    listData,
                                    false,
                                    selectedPageProvider,
                                    editAttendanceDetailProvider),
                              ),
                              Expanded(       
                                  child: tableTotal(
                                      paginatedStudents, listData, false)),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child: tableIntro(listColumnWidth,
                                    paginatedStudents, listData, true),
                              ),
                              Expanded(
                                flex: 2,
                                child: tableCheckAttendance(
                                    numberOfWeeks,
                                    paginatedStudents,
                                    listData,
                                    true,
                                    selectedPageProvider,
                                    editAttendanceDetailProvider),
                              ),
                              Expanded(
                                  child: tableTotal(
                                      paginatedStudents, listData, true)),
                            ],
                          ),
                    const SizedBox(height: 10),
                    showPage(students)
                  ],
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
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
        ),
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

  Widget tableTotal(List<Map<String, String>> paginatedStudents,
      List<StudentData> listData, bool isMobile) {
    return SizedBox(
      width: 100,
      child: Table(
        border: TableBorder.all(color: Colors.grey),
        children: [
          TableRow(children: [
            TableCell(
              child: Container(
                padding: const EdgeInsets.all(5),
                color: Colors.grey.withOpacity(0.21),
                child: Center(
                  child: Text(
                    'Total',
                    style: TextStyle(
                      fontSize: isMobile ? 9 : 11,
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
                  child: Center(
                    child: Text(
                      listData[i].total,
                      style: TextStyle(
                        fontSize: isMobile ? 9 : 11,
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

  double getNumberOfWeeks(int numberOfweeks){
    if (numberOfWeeks == 2){
      return 250;
    }
    else if (numberOfWeeks == 4){
      return 120;
    }
    else {
      return 60;
    }
  }

  Widget tableCheckAttendance(
      int numberOfWeeks,
      List<Map<String, String>> paginatedStudents,
      List<StudentData> listData,
      bool isMobile,
      SelectedPageProvider selectedPageProvider,
      EditAttendanceDetailProvider editAttendanceDetailProvider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: {
            for (int i = 0; i < numberOfWeeks; i++)
              // i: FixedColumnWidth(numberOfWeeks <= 13 ? 60 : 60),
              i: FixedColumnWidth(getNumberOfWeeks(numberOfWeeks))
          },
          children: [
            TableRow(
              children: [
                for (int j = 0; j < numberOfWeeks; j++)
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.grey.withOpacity(0.21),
                      child: Center(
                        child: Tooltip(
                          message: listData[0].attendancedetails.length > j
                              ? listData[0].attendancedetails[j].attendanceForm
                              : '',
                          child: InkWell(
                            onTap: listData[0].attendancedetails.length > j &&
                                    listData[0].attendancedetails.isNotEmpty &&
                                    listData[0]
                                        .attendancedetails[j]
                                        .attendanceForm
                                        .isNotEmpty
                                ? () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                RealtimeCheckAttendance(
                                                    formID: listData[0]
                                                        .attendancedetails[j]
                                                        .attendanceForm,
                                                    classes: listData[0]
                                                        .attendancedetails[j]
                                                        .classDetail,
                                                    classesData:
                                                        widget.classes)));
                                  }
                                : null,
                            mouseCursor: SystemMouseCursors.click,
                            child: Text(
                              'Day ${j + 1}',
                              style: TextStyle(
                                fontSize: isMobile ? 9 : 11,
                                fontWeight: FontWeight.bold,
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
            for (int i = 0; i < paginatedStudents.length; i++)
              TableRow(
                children: List.generate(
                  numberOfWeeks,
                  (j) => TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.white,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            selectedPageProvider.setCheckAttendanceDetail(true);
                            selectedPageProvider.setCheckHome(false);
                            selectedPageProvider.setCheckNoti(false);
                            selectedPageProvider.setCheckReport(false);
                            selectedPageProvider.setCheckForm(false);
                            selectedPageProvider
                                .setCheckEditAttendanceForm(false);
                            selectedPageProvider.setCheckAttendanceForm(false);
                            editAttendanceDetailProvider
                                .setStudentID(listData[i].studentID);
                            editAttendanceDetailProvider.setFormID(listData[i]
                                .attendancedetails[j]
                                .attendanceForm);
                            editAttendanceDetailProvider
                                .setStudentName(listData[i].studentName);
                          },
                          child: Text(
                            j < listData[i].attendancedetails.length
                                ? getResult(
                                    listData[i].attendancedetails[j].result)
                                : '',
                            style: TextStyle(
                              fontSize: isMobile ? 9 : 11,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
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
    );
  }

  Color getColorStatus(String status) {
    if (status.contains('Warning') || status == 'Warning') {
      return const Color.fromARGB(231, 216, 136, 38);
    } else if (status.contains('Ban') || status == 'Ban') {
      return AppColors.importantText;
    } else {
      return Colors.white;
    }
  }

  Color getTextColor(String status) {
    if (status.contains('Warning') || status == 'Warning') {
      return Colors.white;
    } else if (status.contains('Ban') || status == 'Ban') {
      return Colors.white;
    } else {
      return AppColors.primaryText;
    }
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

  String getResult(double result) {
    if (result == 0) {
      return 'Absent';
    } else if (result.toString() == 0.5.toString()) {
      return 'Late';
    } else {
      return 'Present';
    }
  }

  Widget tableIntro(
      listColumnWidth,
      List<Map<String, String>> paginatedStudents,
      List<StudentData> listData,
      bool isMobile) {
    return SizedBox(
      width: 350,
      // height: 350,
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
                child: Center(
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontSize: isMobile ? 9 : 11,
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
                child: Center(
                  child: Text(
                    'StudentID',
                    style: TextStyle(
                      fontSize: isMobile ? 9 : 11,
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
                child: Center(
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: isMobile ? 9 : 11,
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
                  color: getColorStatus(listData[i].status),
                  child: Center(
                    child: Text(
                      '${currentPage * itemsPerPage + i + 1}',
                      style: TextStyle(
                        fontSize: isMobile ? 9 : 11,
                        fontWeight: FontWeight.bold,
                        color: getTextColor(listData[i].status),
                      ),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  color: getColorStatus(listData[i].status),
                  child: Center(
                    child: Text(
                      '${paginatedStudents[i]['studentID']}',
                      style: TextStyle(
                        fontSize: isMobile ? 9 : 11,
                        fontWeight: FontWeight.bold,
                        color: getTextColor(listData[i].status),
                      ),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  color: getColorStatus(listData[i].status),
                  child: Center(
                    child: Text(
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      '${paginatedStudents[i]['name']}',
                      style: TextStyle(
                        fontSize: isMobile ? 9 : 11,
                        fontWeight: FontWeight.bold,
                        color: getTextColor(listData[i].status),
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

  void exportToExcel(
      List<StudentData> studentAttendance, int totalWeeks) async {
    var excel1 = excel.Excel.createExcel();
    var sheet = excel1['Sheet1'];

    List<excel.CellValue> listCellValue = [];
    listCellValue.add(
      const excel.TextCellValue('No'),
    );
    listCellValue.add(
      const excel.TextCellValue('StudentID'),
    );
    listCellValue.add(
      const excel.TextCellValue('Name'),
    );
    listCellValue.add(const excel.TextCellValue('Email'));

    for (int i = 1; i <= totalWeeks; i++) {
      listCellValue.add(excel.TextCellValue('Day $i'));
    }
    listCellValue.add(const excel.TextCellValue('Total'));
    listCellValue.add(const excel.TextCellValue('Status'));

    sheet.appendRow(listCellValue);

    // Add data
    for (int i = 0; i < studentAttendance.length; i++) {
      List<excel.CellValue> studentRow = [];

      studentRow.add(excel.IntCellValue(i + 1)); // No
      studentRow.add(excel.TextCellValue(studentAttendance[i].studentID));
      studentRow.add(excel.TextCellValue(studentAttendance[i].studentName));
      studentRow.add(excel.TextCellValue(studentAttendance[i].studentEmail));

      for (int j = 0; j < studentAttendance[i].attendancedetails.length; j++) {
        studentRow.add(excel.TextCellValue(
            studentAttendance[i].attendancedetails[j].result.toString()));
      }

      for (int j = 0;
          j < totalWeeks - studentAttendance[i].attendancedetails.length;
          j++) {
        studentRow.add(const excel.TextCellValue('null'));
      }
      studentRow.add(excel.TextCellValue(studentAttendance[i].total));
      studentRow
          .add(excel.TextCellValue(statusStudent(studentAttendance[i].status)));
      sheet.appendRow(studentRow);
    }

    int totalColumns = 4 + totalWeeks + 1 + 1;

    for (int i = 1; i <= totalColumns; i++) {
      sheet.setColumnAutoFit(i);
    }
    // Save the Excel file
    excel1.save(fileName: 'My_Excel_File_Name.xlsx');
  }

  String statusStudent(String status) {
    if (status.contains('Pass') || status == 'Pass') {
      return 'Pass';
    } else if (status.contains('Warning') || status == 'Warning') {
      return 'Pass';
    } else if (status.contains('Ban') || status == 'Ban') {
      return 'Ban';
    } else {
      return 'Pass';
    }
  }

  Widget customButtonDashBoard(String nameButton, List<StudentData> listTemp,
      int totalWeeks, bool isMobile) {
    return InkWell(
      onTap: () {
        exportToExcel(listTemp, totalWeeks);
      },
      mouseCursor: SystemMouseCursors.click,
      child: Container(
        width: isMobile ? 60 : 80,
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
              fontSize: isMobile ? 10 : 12,
              fontWeight: FontWeight.normal,
              color: nameButton == 'Export'
                  ? Colors.white
                  : AppColors.primaryText),
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

Widget customBoxInformation(
    String title,
    String imagePath,
    int count,
    Function(String title) function,
    String isSelectedSection,
    Size size,
    bool isMobile) {
  return InkWell(
    onTap: () {
      function(title);
    },
    mouseCursor: SystemMouseCursors.click,
    child: Container(
      width: 200,
      padding: EdgeInsets.symmetric(vertical: size.width < 680 ? 5 : 8),
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
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                    message: title,
                    fontSize: size.width <= 685 ? 14 : 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorInformation),
                CustomText(
                    message: '$count',
                    fontSize: size.width <= 685 ? 12 : 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorNumberInformation),
                CustomText(
                    message: 'Student',
                    fontSize: size.width <= 685 ? 10 : 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText)
              ],
            ),
            Image.asset(
              imagePath,
              width: size.width <= 740 ? 40 : 60,
              height: size.width <= 740 ? 40 : 60,
            )
          ],
        ),
      ),
    ),
  );
}
