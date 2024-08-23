import 'dart:math';
import 'dart:html' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/DetailPage/ClassData.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/home_page/class_data_home_page.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/selected_page_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/widgets/app_bar_mobile.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/widgets/app_bar_tablet.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/class_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/teacher_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/WelcomePage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/DetailPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/CalendarPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/NotificationPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/ReportPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/RepositoryClassPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/SettingPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/Responsive.dart';

import 'package:weblectuer_attendancesystem_nodejs/services/SecureStorage.dart';

import '../../models/Main/home_page/Semester.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  bool checkHome = true;
  bool checkNotification = false;
  bool checkReport = false;
  bool checkRepository = false;
  bool checkCalendar = false;
  bool checkSettings = false;
  final storage = SecureStorage();

  OverlayEntry? overlayEntry;
  int page = 1;

  bool isCollapsedOpen = true;
  late String name;
  int? selectedSemesterID;
  List<Semester> semesters = [];
  String dropdownvalue = '';
  late Future<List<Semester>> _fetchSemester;
  late Future<ClassDataHomePage?> _fetchData;
  ClassDataHomePage? classesData;

  void toggleDrawer() {
    setState(() {
      isCollapsedOpen = !isCollapsedOpen;
    });
  }

  void fetchClasses(int semesterID, bool archived) {
    _fetchData = API(context).getClasses(page, semesterID, archived);
    _fetchData.then((value) {
      setState(() {
        classesData = value;
      });
    });
  }

  void fetchSemester() async {
    _fetchSemester = API(context).getSemester();
    _fetchSemester.then((value) {
      setState(() {
        semesters = value;
        if (semesters.isNotEmpty) {
          dropdownvalue = semesters.first.semesterName ?? '';
          selectedSemesterID = semesters.first.semesterID;
          fetchClasses(selectedSemesterID ?? 0, false);
        }
      });
    });
  }

  Future<void> _loadToken() async {
    String? loadToken = await storage.readSecureData('accessToken');
    String? refreshToken1 = await storage.readSecureData('refreshToken');
    if (loadToken.isEmpty ||
        refreshToken1.isEmpty ||
        loadToken.contains('No Data Found') ||
        refreshToken1.contains('No Data Found')) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadToken();
    fetchSemester();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final classDataProvider =
        Provider.of<ClassDataProvider>(context, listen: false);
    final teacherDataProvider =
        Provider.of<TeacherDataProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    final selectedPageProvider = Provider.of<SelectedPageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(null),
        backgroundColor: AppColors.colorHeader,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Responsive(
            mobile: AppBarMobile(
                size: size,
                context: context,
                teacherDataProvider: teacherDataProvider),
            tablet: AppbarTablet(
                searchController: searchController,
                size: size,
                context: context,
                teacherDataProvider: teacherDataProvider),
            desktop: _appbarDesktop(context, teacherDataProvider),
          ),
        ),
      ),
      body: Responsive(
        mobile:
            _bodyMobile(size, context, classDataProvider, selectedPageProvider),
        tablet:
            _bodyTablet(size, context, classDataProvider, selectedPageProvider),
        desktop: _bodyDesktop(
            context, classDataProvider, size, selectedPageProvider),
      ),
    );
  }

  Row _bodyMobile(
      Size size,
      BuildContext context,
      ClassDataProvider classDataProvider,
      SelectedPageProvider selectedPageProvider) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: size.width > 650 ? 200 : 60,
          child: size.width > 650
              ? Container(
                  width: 250,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomText(
                            message: 'Main',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryText),
                        itemHeader(
                            'Home', const Icon(Icons.home_outlined), checkHome),
                        const CustomText(
                            message: 'Analyze',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryText),
                        itemHeader(
                            'Notifications',
                            const Icon(Icons.notifications_outlined),
                            checkNotification),
                        itemHeader('Reports', const Icon(Icons.book_outlined),
                            checkReport),
                        const CustomText(
                            message: 'Manage',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryText),
                        itemHeader(
                            'Repository Class',
                            const Icon(Icons.cloud_download_outlined),
                            checkRepository),
                        itemHeader(
                            'Calendar',
                            const Icon(Icons.calendar_month_outlined),
                            checkCalendar),
                        const CustomText(
                            message: 'Personal',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryText),
                        itemHeader('Settings',
                            const Icon(Icons.settings_outlined), checkSettings),
                      ],
                    ),
                  ),
                )
              : Container(
                  width: 60,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            checkHome = true;
                            checkNotification = false;
                            checkReport = false;
                            checkRepository = false;
                            checkCalendar = false;
                            checkSettings = false;
                          });
                        },
                        child: iconCollapseSideBar(
                            const Icon(Icons.home_outlined), checkHome),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            checkHome = false;
                            checkNotification = true;
                            checkReport = false;
                            checkRepository = false;
                            checkCalendar = false;
                            checkSettings = false;
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
                            checkRepository = false;
                            checkCalendar = false;
                            checkSettings = false;
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
                            checkRepository = true;
                            checkCalendar = false;
                            checkSettings = false;
                          });
                        },
                        child: iconCollapseSideBar(
                          const Icon(Icons.cloud_download_outlined),
                          checkRepository,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            checkHome = false;
                            checkNotification = false;
                            checkReport = false;
                            checkRepository = false;
                            checkCalendar = true;
                            checkSettings = false;
                          });
                        },
                        child: iconCollapseSideBar(
                          const Icon(Icons.calendar_month_outlined),
                          checkCalendar,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            checkHome = false;
                            checkNotification = false;
                            checkReport = false;
                            checkRepository = false;
                            checkCalendar = false;
                            checkSettings = true;
                          });
                        },
                        child: iconCollapseSideBar(
                          const Icon(Icons.settings_outlined),
                          checkSettings,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        Expanded(
          flex: 6,
          child:
              selectedPage(classDataProvider, size, true, selectedPageProvider),
        ),
      ],
    );
  }

  Row _bodyTablet(
      Size size,
      BuildContext context,
      ClassDataProvider classDataProvider,
      SelectedPageProvider selectedPageProvider) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: size.width > 990 ? 200 : 60,
          child: size.width > 990
              ? Container(
                  width: 250,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomText(
                            message: 'Main',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryText),
                        itemHeader(
                            'Home', const Icon(Icons.home_outlined), checkHome),
                        const CustomText(
                            message: 'Analyze',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryText),
                        itemHeader(
                            'Notifications',
                            const Icon(Icons.notifications_outlined),
                            checkNotification),
                        itemHeader('Reports', const Icon(Icons.book_outlined),
                            checkReport),
                        const CustomText(
                            message: 'Manage',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryText),
                        itemHeader(
                            'Repository Class',
                            const Icon(Icons.cloud_download_outlined),
                            checkRepository),
                        itemHeader(
                            'Calendar',
                            const Icon(Icons.calendar_month_outlined),
                            checkCalendar),
                        const CustomText(
                            message: 'Personal',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryText),
                        itemHeader('Settings',
                            const Icon(Icons.settings_outlined), checkSettings),
                      ],
                    ),
                  ),
                )
              : Container(
                  width: 60,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            checkHome = true;
                            checkNotification = false;
                            checkReport = false;
                            checkRepository = false;
                            checkCalendar = false;
                            checkSettings = false;
                          });
                        },
                        child: iconCollapseSideBar(
                            const Icon(Icons.home_outlined), checkHome),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            checkHome = false;
                            checkNotification = true;
                            checkReport = false;
                            checkRepository = false;
                            checkCalendar = false;
                            checkSettings = false;
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
                            checkRepository = false;
                            checkCalendar = false;
                            checkSettings = false;
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
                            checkRepository = true;
                            checkCalendar = false;
                            checkSettings = false;
                          });
                        },
                        child: iconCollapseSideBar(
                          const Icon(Icons.cloud_download_outlined),
                          checkRepository,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            checkHome = false;
                            checkNotification = false;
                            checkReport = false;
                            checkRepository = false;
                            checkCalendar = true;
                            checkSettings = false;
                          });
                        },
                        child: iconCollapseSideBar(
                          const Icon(Icons.calendar_month_outlined),
                          checkCalendar,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            checkHome = false;
                            checkNotification = false;
                            checkReport = false;
                            checkRepository = false;
                            checkCalendar = false;
                            checkSettings = true;
                          });
                        },
                        child: iconCollapseSideBar(
                          const Icon(Icons.settings_outlined),
                          checkSettings,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        Expanded(
          flex: 6,
          child: selectedPage(
              classDataProvider, size, false, selectedPageProvider),
        ),
      ],
    );
  }

  Row _bodyDesktop(BuildContext context, ClassDataProvider classDataProvider,
      Size size, SelectedPageProvider selectedPageProvider) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isCollapsedOpen ? 250 : 80,
          child: isCollapsedOpen
              ? _leftHeader(context)
              : _collapsedSideBar(context),
        ),
        Expanded(
          flex: 5,
          child: selectedPage(
              classDataProvider, size, false, selectedPageProvider),
        ),
      ],
    );
  }

  Container _collapsedSideBar(BuildContext context) {
    return Container(
      width: 80,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                checkHome = true;
                checkNotification = false;
                checkReport = false;
                checkRepository = false;
                checkCalendar = false;
                checkSettings = false;
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
                checkRepository = false;
                checkCalendar = false;
                checkSettings = false;
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
                checkRepository = false;
                checkCalendar = false;
                checkSettings = false;
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
                checkRepository = true;
                checkCalendar = false;
                checkSettings = false;
              });
            },
            child: iconCollapseSideBar(
              const Icon(Icons.cloud_download_outlined),
              checkRepository,
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                checkHome = false;
                checkNotification = false;
                checkReport = false;
                checkRepository = false;
                checkCalendar = true;
                checkSettings = false;
              });
            },
            child: iconCollapseSideBar(
              const Icon(Icons.calendar_month_outlined),
              checkCalendar,
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                checkHome = false;
                checkNotification = false;
                checkReport = false;
                checkRepository = false;
                checkCalendar = false;
                checkSettings = true;
              });
            },
            child: iconCollapseSideBar(
              const Icon(Icons.settings_outlined),
              checkSettings,
            ),
          ),
        ],
      ),
    );
  }

  Container _leftHeader(BuildContext context) {
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
                message: 'Main',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryText),
            itemHeader('Home', const Icon(Icons.home_outlined), checkHome),
            const CustomText(
                message: 'Analyze',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryText),
            itemHeader('Notifications',
                const Icon(Icons.notifications_outlined), checkNotification),
            itemHeader('Reports', const Icon(Icons.book_outlined), checkReport),
            const CustomText(
                message: 'Manage',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryText),
            itemHeader('Repository Class',
                const Icon(Icons.cloud_download_outlined), checkRepository),
            itemHeader('Calendar', const Icon(Icons.calendar_month_outlined),
                checkCalendar),
            const CustomText(
                message: 'Personal',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryText),
            itemHeader(
                'Settings', const Icon(Icons.settings_outlined), checkSettings),
          ],
        ),
      ),
    );
  }

  Widget _appbarDesktop(
      BuildContext context, TeacherDataProvider teacherDataProvider) {
    return Row(
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

  Container iconCollapseSideBar(Icon icon, bool check) {
    return Container(
        width: 80,
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
      onTap: () async {
        ClassDataHomePage? data =
            await API(context).getClasses(page, selectedSemesterID, false);
        setState(() {
          checkHome = false;
          checkNotification = false;
          checkReport = false;
          checkRepository = false;
          checkCalendar = false;
          checkSettings = false;
          if (title == 'Home') {
            checkHome = true;
            classesData = data;
          } else if (title == 'Notifications') {
            checkNotification = true;
          } else if (title == 'Reports') {
            checkReport = true;
          } else if (title == 'Repository Class') {
            checkRepository = true;
          } else if (title == 'Calendar') {
            checkCalendar = true;
          } else if (title == 'Settings') {
            checkSettings = true;
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

  Widget selectedPage(ClassDataProvider classDataProvider, Size size,
      bool isMobile, SelectedPageProvider selectedPageProvider) {
    if (checkHome) {
      // html.window.history.pushState({}, 'Notification', '/HomePage/123213');
      return containerHome(
          classDataProvider, size, isMobile, selectedPageProvider);
      // return const ReportPage();
    } else if (checkNotification) {
      // html.window.history.pushState({}, 'Notification', '/Detail/Notification');
      return const NotificationPage();
    } else if (checkReport) {
      return const ReportPage();
    } else if (checkRepository) {
      return const RepositoryClassPage();
    } else if (checkCalendar) {
      return const CalendarPage();
    } else if (checkSettings) {
      return const SettingPage();
    } else {
      return containerHome(
          classDataProvider, size, isMobile, selectedPageProvider);
    }
  }

  Widget customClass(
    List<Class>? classes,
    String classID,
    String className,
    String typeClass,
    String group,
    String subGroup,
    int shiftNumber,
    String room,
    String imgPath,
    double height,
  ) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: const Offset(0, 5),
            color: Colors.black.withOpacity(0.1),
          )
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                SizedBox(
                  height: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      imgPath,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        className,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Group: $group - Sub: $subGroup | ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Type: $typeClass',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Shift: $shiftNumber | ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Room: $room',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    onSelected: (value) {},
                    itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          value: '/repository',
                          child: Text("Repository"),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Repository'),
                                  content: Text(
                                      'Are you sure you want to repository this class?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () async {
                                        // Perform your deactivation logic here
                                        bool result = await API(context)
                                            .repositoryClassbyID(classID, true);
                                        if (result) {
                                          Navigator.of(context).pop();
                                          _customDialog(
                                              'Class $className',
                                              'You changed repository successfully',
                                              classID,
                                              classes);
                                        } else {
                                          Navigator.of(context).pop();
                                          _customDialog(
                                              'Class $className',
                                              'Transfer to repository failed',
                                              classID,
                                              classes);
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        PopupMenuItem(
                          value: '/delete',
                          child: Text("Delete"),
                        ),
                      ];
                    },
                  ),
                )
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_2_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.document_scanner_outlined),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<dynamic> _customDialog(
      String title, String subTitle, String classID, List<Class>? classes) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subTitle),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                // Perform your deactivation logic here
                ClassDataHomePage? data = await API(context)
                    .getClasses(page, selectedSemesterID, false);
                setState(() {
                  classesData = data;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPopupMenu(BuildContext context) {
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 40,
        left: 1150,
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.white,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PopupMenuItem(
                  child: Text("My Profile"),
                ),
                PopupMenuItem(
                  child: Text("Log Out"),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  Widget cusTomText(
      String message, double fontSize, FontWeight fontWeight, Color color) {
    return Text(message,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: GoogleFonts.inter(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }

  Widget containerHome(ClassDataProvider classDataProvider, Size size,
      bool isMobile, SelectedPageProvider selectedPageProvider) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  message: 'Home',
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomText(
                      message: 'Select semester',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.primaryText.withOpacity(0.2))),
                    child: DropdownButton<String>(
                      focusColor: Colors.transparent,
                      underline: Container(),
                      value: dropdownvalue,
                      onChanged: (String? newValue) async {
                        selectedSemesterID = semesters
                            .firstWhere(
                                (semester) => semester.semesterName == newValue)
                            .semesterID;
                        ClassDataHomePage? data = await API(context)
                            .getClasses(page, selectedSemesterID, false);
                        setState(() {
                          dropdownvalue = newValue!;
                          classesData = data;
                        });
                      },
                      iconSize: 15,
                      menuMaxHeight: 150,
                      style: TextStyle(fontSize: 15),
                      items: semesters
                          .map<DropdownMenuItem<String>>((Semester value) {
                        return DropdownMenuItem<String>(
                          value: value.semesterName,
                          child: Text(value.semesterName ?? ''),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // FutureBuilder(
              //   future:
              //       API(context).getClasses(page, selectedSemesterID, false),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       if (snapshot.data != null) {
              //         ClassDataHomePage? classesData = snapshot.data;
              //         // Future.delayed(Duration.zero, () {
              //         //   classDataProvider.setAttendanceFormData(classes!);
              //         // });
              //         return !isMobile
              //             ? Column(
              //                 children: [
              //                   _gridViewData(size, classesData?.classes),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                   _buildPaginationButtons(
              //                       classesData?.totalPage ?? 1),
              //                 ],
              //               )
              //             : Column(
              //                 children: [
              //                   ListView.separated(
              //                     shrinkWrap: true,
              //                     padding: EdgeInsets.zero,
              //                     itemCount: classesData?.classes?.length ?? 0,
              //                     itemBuilder: (context, index) {
              //                       Class data =
              //                           classesData?.classes?[index] ?? Class();
              //                       var randomBanner = Random().nextInt(2);
              //                       return InkWell(
              //                         onTap: () {
              //                           selectedPageProvider
              //                               .setCheckAttendanceDetail(false);
              //                           selectedPageProvider.setCheckHome(true);
              //                           selectedPageProvider
              //                               .setCheckNoti(false);
              //                           selectedPageProvider
              //                               .setCheckReport(false);
              //                           selectedPageProvider
              //                               .setCheckForm(false);
              //                           selectedPageProvider
              //                               .setCheckEditAttendanceForm(false);
              //                           selectedPageProvider
              //                               .setCheckAttendanceForm(false);
              //                           Navigator.pushReplacement(
              //                               context,
              //                               MaterialPageRoute(
              //                                   builder: (builder) =>
              //                                       DetailPage(
              //                                         classes: data,
              //                                       )));
              //                         },
              //                         mouseCursor: SystemMouseCursors.click,
              //                         child: customClass(
              //                             classesData?.classes ?? [],
              //                             data.classID ?? '',
              //                             data.course?.courseName ?? '',
              //                             data.classType ?? '',
              //                             data.group ?? '',
              //                             data.subGroup ?? '',
              //                             data.shiftNumber ?? 0,
              //                             data.roomNumber ?? '',
              //                             'assets/images/banner$randomBanner.jpg',
              //                             150),
              //                       );
              //                     },
              //                     separatorBuilder:
              //                         (BuildContext context, int index) {
              //                       return const SizedBox(
              //                         height: 10,
              //                       );
              //                     },
              //                   ),
              //                   _buildPaginationButtons(
              //                       classesData?.totalPage ?? 1),
              //                 ],
              //               );
              //       }
              //     } else if (snapshot.hasError) {
              //       return Center(child: Text('Error: ${snapshot.error}'));
              //     } else if (snapshot.connectionState ==
              //         ConnectionState.waiting) {
              //       return const Center(
              //           child: CircularProgressIndicator(
              //               color: AppColors.primaryButton));
              //     } else {
              //       return Center(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Opacity(
              //                 opacity: 0.3,
              //                 child: Image.asset(
              //                   'assets/images/nodata.png',
              //                   width: 200,
              //                   height: 200,
              //                 )),
              //             const SizedBox(height: 5),
              //             CustomText(
              //                 message: 'No Class',
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w600,
              //                 color: AppColors.primaryText.withOpacity(0.3))
              //           ],
              //         ),
              //       );
              //     }
              //     return const Center(child: Text('Data is not available'));
              //   },
              // ),
              !isMobile
                  ? classesData != null
                      ? Column(
                          children: [
                            _gridViewData(size, classesData?.classes),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildPaginationButtons(
                                classesData?.totalPage ?? 1),
                          ],
                        )
                      : _noData()
                  : classesData != null
                      ? Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: classesData?.classes?.length ?? 0,
                              itemBuilder: (context, index) {
                                Class data =
                                    classesData?.classes?[index] ?? Class();
                                var randomBanner = Random().nextInt(2);
                                return InkWell(
                                  onTap: () {
                                    selectedPageProvider
                                        .setCheckAttendanceDetail(false);
                                    selectedPageProvider.setCheckHome(true);
                                    selectedPageProvider.setCheckNoti(false);
                                    selectedPageProvider.setCheckReport(false);
                                    selectedPageProvider.setCheckForm(false);
                                    selectedPageProvider
                                        .setCheckEditAttendanceForm(false);
                                    selectedPageProvider
                                        .setCheckAttendanceForm(false);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => DetailPage(
                                                  classes: data,
                                                )));
                                  },
                                  mouseCursor: SystemMouseCursors.click,
                                  child: customClass(
                                      classesData?.classes ?? [],
                                      data.classID ?? '',
                                      data.course?.courseName ?? '',
                                      data.classType ?? '',
                                      data.group ?? '',
                                      data.subGroup ?? '',
                                      data.shiftNumber ?? 0,
                                      data.roomNumber ?? '',
                                      'assets/images/banner$randomBanner.jpg',
                                      150),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                            ),
                            _buildPaginationButtons(
                                classesData?.totalPage ?? 1),
                          ],
                        )
                      : _noData()
            ],
          ),
        ),
      ),
    );
  }

  Center _noData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/nodata.png',
                width: 200,
                height: 200,
              )),
          const SizedBox(height: 5),
          CustomText(
              message: 'No Class',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText.withOpacity(0.3))
        ],
      ),
    );
  }

  GridView _gridViewData(Size size, List<Class>? classes) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: size.width <= 860 ? 2 : 3,
            crossAxisSpacing: 15,
            childAspectRatio: 16 / 9,
            mainAxisSpacing: 15),
        itemCount: classes?.length ?? 0,
        itemBuilder: (context, index) {
          Class data = classes?[index] ?? Class();
          var randomBanner = Random().nextInt(2);

          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => DetailPage(
                            classes: data,
                          )));
            },
            mouseCursor: SystemMouseCursors.click,
            child: Container(
              child: customClass(
                  classes,
                  data.classID ?? '',
                  data.course?.courseName ?? '',
                  data.classType ?? '',
                  data.group ?? '',
                  data.subGroup ?? '',
                  data.shiftNumber ?? 0,
                  data.roomNumber ?? '',
                  'assets/images/banner$randomBanner.jpg',
                  550),
            ),
          );
        });
  }

  Widget _buildPaginationButtons(int totalPage) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: page > 1
              ? () async {
                  setState(() {
                    page--;
                  });
                  ClassDataHomePage? data = await API(context)
                      .getClasses(page, selectedSemesterID, false);
                  setState(() {
                    classesData = data;
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
              ? () async {
                  setState(() {
                    page++;
                  });
                  ClassDataHomePage? data = await API(context)
                      .getClasses(page, selectedSemesterID, false);
                  setState(() {
                    classesData = data;
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
}
