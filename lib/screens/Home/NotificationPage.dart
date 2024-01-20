import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Notification.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<NotificationDetail> notificationList = [
      NotificationDetail(
          title:
              'Student ABC from the cross platform programming has sent you a report',
          role: 'Student',
          dateSend: '8/11/2023'),
      NotificationDetail(
          title:
              'Student ABC from the cross platform programming has sent you a report',
          role: 'Student',
          dateSend: '8/11/2023'),
      NotificationDetail(
          title:
              'Student ABC from the cross platform programming has sent you a report',
          role: 'Student',
          dateSend: '8/11/2023'),
      NotificationDetail(
          title:
              'Student ABC from the cross platform programming has sent you a report',
          role: 'Student',
          dateSend: '8/11/2023'),
      NotificationDetail(
          title:
              'Student ABC from the cross platform programming has sent you a report',
          role: 'Student',
          dateSend: '8/11/2023'),
      NotificationDetail(
          title:
              'Student ABC from the cross platform programming has sent you a report',
          role: 'Student',
          dateSend: '8/11/2023'),
      NotificationDetail(
          title:
              'Student ABC from the cross platform programming has sent you a report',
          role: 'Student',
          dateSend: '8/11/2023'),
    ];
    return Container(
      width: MediaQuery.of(context).size.width - 250,
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
                  message: 'Notifications',
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 250,
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customBoxInformation('All', 'assets/icons/all.jpg'),
                    customBoxInformation('Old', 'assets/icons/old.jpg'),
                    customBoxInformation('New', 'assets/icons/news.png'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 250,
                height: 450,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    importantNotifications(notificationList),
                    lastestNotifications(notificationList),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customBoxInformation(String title, String imagePath) {
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
                  const CustomText(
                      message: '0',
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

  Widget importantNotifications(List notifications) {
    return Container(
      width: 610,
      height: 450,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.star_rounded,
                size: 20,
                color: Colors.yellow,
              ),
              const CustomText(
                  message: 'IMPORTANT NOTIFICATIONS',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText),
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
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                NotificationDetail data = notifications[index];
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      mouseCursor: SystemMouseCursors.click,
                      title: CustomText(
                        message: data.title,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff0161ae),
                      ),
                      subtitle: Row(
                        children: [
                          CustomText(
                            message: '{${data.role}} - ${data.dateSend}',
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
        ],
      ),
    );
  }

  Widget lastestNotifications(List notifications) {
    return Container(
      width: 290,
      height: 450,
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
          Container(
            height: 61,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.yellow,
                    ),
                    CustomText(
                        message: 'LATEST NOTIFICATIONS',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('All Notifications',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4154f1),
                        decoration: TextDecoration.underline,
                      )),
                )
              ],
            ),
          ),
          const Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(32, 203, 203, 203)),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                NotificationDetail data = notifications[index];
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      mouseCursor: SystemMouseCursors.click,
                      title: CustomText(
                        message: data.title,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff0161ae),
                      ),
                      subtitle: Row(
                        children: [
                          CustomText(
                            message: '{${data.role}} - ${data.dateSend}',
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
        ],
      ),
    );
  }
}
