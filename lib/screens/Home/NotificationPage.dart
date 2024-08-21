import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Notification/NotificationsData.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Notification/ReportNotifications.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Notification.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/Responsive.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    super.key,
  });

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<NotificationsData?> futureNotifications;
  NotificationsData? notificationsData;

  void fetchData() async {
    futureNotifications = API(context).getNotifications();
    futureNotifications.then((value) {
      setState(() {
        notificationsData = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Responsive(
      mobile: Container(color: Colors.amber),
      tablet: _bodyTablet(context, size),
      desktop: _bodyDesktop(context, size),
    );
  }

  SizedBox _bodyTablet(BuildContext context, Size size) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      child: notificationsData != null
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                        message: 'Notifications',
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
                        children: [
                          Expanded(
                            child: customBoxInformation(
                                'All',
                                'assets/icons/all.jpg',
                                notificationsData?.total ?? 0,
                                size),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: customBoxInformation(
                                'Old',
                                'assets/icons/old.jpg',
                                notificationsData?.totalOld ?? 0,
                                size),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: customBoxInformation(
                                'New',
                                'assets/icons/news.png',
                                notificationsData?.totalNew ?? 0,
                                size),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 250,
                      height: 450,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 3,
                            child: importantNotifications(
                                notificationsData?.importantNews ?? [], size),
                          ),
                          Expanded(
                            child: lastestNotifications(
                                notificationsData?.latestNews ?? [], size),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                        message: 'Notifications',
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
                        children: [
                          Expanded(
                            child: customBoxInformation(
                                'All',
                                'assets/icons/all.jpg',
                                notificationsData?.total ?? 0,
                                size),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: customBoxInformation(
                                'Old',
                                'assets/icons/old.jpg',
                                notificationsData?.totalOld ?? 0,
                                size),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: customBoxInformation(
                                'New',
                                'assets/icons/news.png',
                                notificationsData?.totalNew ?? 0,
                                size),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 250,
                      height: 400,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: importantNotifications(
                                notificationsData?.importantNews ?? [], size),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: lastestNotifications(
                                notificationsData?.latestNews ?? [], size),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  SizedBox _bodyDesktop(BuildContext context, Size size) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      child: notificationsData != null
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                        message: 'Notifications',
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
                        children: [
                          Expanded(
                            child: customBoxInformation(
                                'All',
                                'assets/icons/all.jpg',
                                notificationsData?.total ?? 0,
                                size),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: customBoxInformation(
                                'Old',
                                'assets/icons/old.jpg',
                                notificationsData?.totalOld ?? 0,
                                size),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: customBoxInformation(
                                'New',
                                'assets/icons/news.png',
                                notificationsData?.totalNew ?? 0,
                                size),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 250,
                      height: 450,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 3,
                            child: importantNotifications(
                                notificationsData?.importantNews ?? [], size),
                          ),
                          Expanded(
                            child: lastestNotifications(
                                notificationsData?.latestNews ?? [], size),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                        message: 'Notifications',
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
                        children: [
                          Expanded(
                            child: customBoxInformation(
                                'All',
                                'assets/icons/all.jpg',
                                notificationsData?.total ?? 0,
                                size),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: customBoxInformation(
                                'Old',
                                'assets/icons/old.jpg',
                                notificationsData?.totalOld ?? 0,
                                size),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: customBoxInformation(
                                'New',
                                'assets/icons/news.png',
                                notificationsData?.totalNew ?? 0,
                                size),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 250,
                      height: 400,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: importantNotifications(
                                notificationsData?.importantNews ?? [], size),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: lastestNotifications(
                                notificationsData?.latestNews ?? [], size),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget customBoxInformation(
      String title, String imagePath, int number, Size size) {
    return InkWell(
      onTap: () {},
      mouseCursor: SystemMouseCursors.click,
      child: Container(
        width: 250,
        height: 115,
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
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      message: title,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorInformation),
                  CustomText(
                      message: number.toString(),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorNumberInformation),
                  const CustomText(
                      message: 'News Unread',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText)
                ],
              ),
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget importantNotifications(
      List<ReportNotifications> notifications, Size size) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: const Color.fromARGB(55, 203, 203, 203)),
          boxShadow: const [
            BoxShadow(
                color: AppColors.secondaryText,
                blurRadius: 2,
                offset: Offset(0, 2))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.yellow,
                    ),
                    SizedBox(width: 5),
                    CustomText(
                        message: 'IMPORTANT NOTIFICATIONS',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('All Notifications',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4154f1),
                        decoration: TextDecoration.underline,
                      )),
                )
              ],
            ),
            const Divider(
                height: 1,
                thickness: 1,
                color: Color.fromARGB(32, 203, 203, 203)),
            notifications.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        ReportNotifications data = notifications[index];
                        return Material(
                          color: data.isImportant == 0
                              ? AppColors.colorHeader.withOpacity(0.3)
                              : Colors.white,
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              mouseCursor: SystemMouseCursors.click,
                              title: Text(
                                  "Student ${data.studentID} from class ${data.classID} has sent report ${data.topic?.toLowerCase()}" ??
                                      '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff0161ae))),
                              subtitle: Row(
                                children: [
                                  CustomText(
                                    message:
                                        '{${data.studentID}} - ${formatTime(data.createdAt ?? '')}',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryText,
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.stars_rounded,
                                    size: 15,
                                    color: Colors.yellow,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
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
                              message: 'No Notifications',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText.withOpacity(0.3))
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget lastestNotifications(
      List<ReportNotifications> notifications, Size size) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: const Color.fromARGB(55, 203, 203, 203)),
          boxShadow: const [
            BoxShadow(
                color: AppColors.secondaryText,
                blurRadius: 2,
                offset: Offset(0, 2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: size.width <= 1330 ? 16 : 20,
                        color: Colors.yellow,
                      ),
                      CustomText(
                          message: 'LATEST NOTIFICATIONS',
                          fontSize: size.width <= 1330 ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('All Notifications',
                        style: TextStyle(
                          fontSize: size.width <= 1330 ? 10 : 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff4154f1),
                          decoration: TextDecoration.underline,
                        )),
                  )
                ],
              ),
            ),
          ),
          const Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(32, 203, 203, 203)),
          const SizedBox(
            height: 5,
          ),
          notifications.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      ReportNotifications data = notifications[index];
                      return Material(
                        color: data.isNew == 0
                            ? AppColors.colorHeader.withOpacity(0.3)
                            : Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: ListTile(
                            mouseCursor: SystemMouseCursors.click,
                            title: Text(
                                "Student ${data.studentID} from class ${data.classID} has sent report ${data.topic?.toLowerCase()}" ??
                                    '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff0161ae))),
                            subtitle: Row(
                              children: [
                                CustomText(
                                  message:
                                      '{${data.studentID}} - ${formatTime(data.createdAt ?? '')}',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondaryText,
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.stars_rounded,
                                  size: 12,
                                  color: Colors.yellow,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              'assets/images/nodata.png',
                              width: 150,
                              height: 150,
                            )),
                        const SizedBox(height: 5),
                        CustomText(
                            message: 'No Notifications',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText.withOpacity(0.3))
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
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
}
