import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
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

import 'package:weblectuer_attendancesystem_nodejs/services/SecureStorage.dart';

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

  bool isCollapsedOpen = true;
  late String name;

  void toggleDrawer() {
    setState(() {
      isCollapsedOpen = !isCollapsedOpen;
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
    // TODO: implement initState
    super.initState();
    _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    final classDataProvider =
        Provider.of<ClassDataProvider>(context, listen: false);
    final teacherDataProvider =
        Provider.of<TeacherDataProvider>(context, listen: false);
    return Scaffold(
      appBar: appBar(teacherDataProvider),
      body: SingleChildScrollView(
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isCollapsedOpen ? 250 : 70,
              child: isCollapsedOpen ? leftHeader() : collapsedSideBar(),
            ),
            Expanded(
              child: selectedPage(classDataProvider),
            ),
          ],
        ),
      ),
    );
  }

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

  PreferredSizeWidget appBar(TeacherDataProvider teacherDataProvider) {
    return AppBar(
      leading: const Icon(null),
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
          checkRepository = false;
          checkCalendar = false;
          checkSettings = false;
          if (title == 'Home') {
            checkHome = true;
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
              height: 5,
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

  Widget selectedPage(ClassDataProvider classDataProvider) {
    if (checkHome) {
      return containerHome(classDataProvider);
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
      return containerHome(classDataProvider);
    }
  }

  Widget customClass(String className, String typeClass, String group,
      String subGroup, int shiftNumber, String room, String imgPath) {
    return SizedBox(
        width: 380,
        height: 210,
        child: Card(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 375,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      imgPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 265,
                              child: cusTomText(
                                  className, 18, FontWeight.bold, Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                CustomText(
                                    message:
                                        'Group: $group - Sub: $subGroup | ',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                CustomText(
                                    message: 'Type: $typeClass',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                CustomText(
                                    message: 'Shift: $shiftNumber | ',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                CustomText(
                                    message: 'Room: $room',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ],
                            )
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        iconColor: Colors.white,
                        onSelected: (value) {},
                        itemBuilder: (BuildContext bc) {
                          return const [
                            PopupMenuItem(
                              value: '/repository',
                              child: Text("Repository"),
                            ),
                            PopupMenuItem(
                              value: '/delete',
                              child: Text("Delete"),
                            ),
                          ];
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 215, right: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.person_2_outlined)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.document_scanner_outlined))
                ],
              ),
            )
          ],
        )));
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

  void _removePopupMenu() {
    overlayEntry?.remove();
  }

  Widget cusTomText(
      String message, double fontSize, FontWeight fontWeight, Color color) {
    return Text(message,
        overflow: TextOverflow.ellipsis,
        maxLines: null,
        style: GoogleFonts.inter(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }

  Widget containerHome(ClassDataProvider classDataProvider) {
    return SizedBox(
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
                message: 'Home',
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryText),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                future: API(context).getClassForTeacher(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      List<Class>? classes = snapshot.data;
                      Future.delayed(Duration.zero, () {
                        classDataProvider.setAttendanceFormData(classes!);
                      });
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 2.1,
                                  mainAxisSpacing: 10),
                          itemCount: classes!.length,
                          itemBuilder: (context, index) {
                            Class data = classes[index];
                            var randomBanner = Random().nextInt(3);

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
                                    data.course!.courseName,
                                    data.classType!,
                                    data.group!,
                                    data.subGroup!,
                                    data.shiftNumber!,
                                    data.roomNumber!,
                                    'assets/images/banner$randomBanner.jpg'),
                              ),
                            );
                          });
                    }
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryButton));
                  }
                  return const Center(child: Text('Data is not available'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
