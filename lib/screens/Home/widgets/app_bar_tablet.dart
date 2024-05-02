import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomTextField.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/teacher_data_provider.dart';

class AppbarTablet extends StatelessWidget {
  const AppbarTablet({
    super.key,
    required this.searchController,
    required this.size,
    required this.context,
    required this.teacherDataProvider,
  });

  final TextEditingController searchController;
  final Size size;
  final BuildContext context;
  final TeacherDataProvider teacherDataProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            SizedBox(width: size.width >= 700 ? 160 : 120),
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
}