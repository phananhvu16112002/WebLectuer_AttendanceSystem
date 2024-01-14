import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/CreateAttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/FormPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/NotificationPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/ReportPage.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController searchController = TextEditingController();
  bool checkHome = true;
  bool checkNotification = false;
  bool checkReport = false;
  bool checkForm = false;
  bool checkAttendaceForm = false;

  OverlayEntry? overlayEntry;
  List<Class> classList = [
    Class(
      nameClass: 'Cross-Platform Programming',
      schedule: 'Tuesday, Shift: 2',
      room: 'A0503',
      imgPath: 'assets/images/banner1.jpg',
    ),
    Class(
        nameClass: 'Data Mining',
        schedule: 'Monday, Shift: 3',
        room: 'A0395',
        imgPath: 'assets/images/image_card.jpeg'),
    Class(
        nameClass: 'Introduction to Networking',
        schedule: 'Monday, Shift: 3',
        room: 'A0395',
        imgPath: 'assets/images/banner2.jpg'),
    Class(
      nameClass: 'Cross-Platform Programming',
      schedule: 'Tuesday, Shift: 2',
      room: 'A0503',
      imgPath: 'assets/images/banner1.jpg',
    ),
    Class(
      nameClass: 'Cross-Platform Programming',
      schedule: 'Tuesday, Shift: 2',
      room: 'A0503',
      imgPath: 'assets/images/banner1.jpg',
    ),
    Class(
        nameClass: 'Data Mining',
        schedule: 'Monday, Shift: 3',
        room: 'A0395',
        imgPath: 'assets/images/image_card.jpeg'),
    Class(
        nameClass: 'Introduction to Networking',
        schedule: 'Monday, Shift: 3',
        room: 'A0395',
        imgPath: 'assets/images/banner2.jpg'),
    Class(
        nameClass: 'Introduction to Networking',
        schedule: 'Monday, Shift: 3',
        room: 'A0395',
        imgPath: 'assets/images/banner2.jpg'),
    Class(
        nameClass: 'Data Mining',
        schedule: 'Monday, Shift: 3',
        room: 'A0395',
        imgPath: 'assets/images/image_card.jpeg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            Row(
              children: [leftHeader(), selectedPage()],
            )
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: AppColors.colorHeader,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
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
                    onPressed: () {},
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
                    position: RelativeRect.fromLTRB(300, 50, 30, 100),
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

  Widget itemHeader(String title, Icon icon, bool check) {
    return InkWell(
      onTap: () {
        setState(() {
          checkHome = false;
          checkNotification = false;
          checkReport = false;
          checkForm = false;
          checkAttendaceForm = false;

          if (title == 'Home') {
            checkHome = true;
          } else if (title == 'Notifications') {
            checkNotification = true;
          } else if (title == 'Reports') {
            checkReport = true;
          } else if (title == 'Forms') {
            checkForm = true;
          } else if (title == 'AttendanceForm') {
            checkAttendaceForm = true;
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
                backgroundColorButton: Colors.transparent,
                borderColor: Colors.black,
                textColor: AppColors.textName,
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) =>
                              const CreateAttendanceFormPage()));
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
            itemHeader(
                'Forms', const Icon(Icons.edit_document), checkAttendaceForm),
          ],
        ),
      ),
    );
  }

  Widget selectedPage() {
    if (checkHome) {
      return containerHome();
    } else if (checkNotification) {
      return const NotificationPage();
    } else if (checkReport) {
      return const ReportPage();
    } else if (checkForm) {
      return const FormPage();
    } else if (checkAttendaceForm) {
      return const CreateAttendanceFormPage();
    } else {
      return containerHome();
    }
  }

  Container containerHome() {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      child: const Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            CustomText(
                message: 'Dashboard',
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryText),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
