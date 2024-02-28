import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceForm.dart';


class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _RepositoryClassPageState();
}

class _RepositoryClassPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const CustomText(
                message: 'Forms',
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryText),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.25,
                            mainAxisSpacing: 10),
                    itemCount: AttendanceForm.getData().length,
                    itemBuilder: (context, index) {
                      final form = AttendanceForm.getData()[index];
                      return customForm(
                          form.formID,
                          form.classes,
                          '5',
                          'A0503',
                          form.dateOpen,
                          form.typeAttendance,
                          form.startTime,
                          form.endTime);
                    })),
          ],
        ),
      ),
    );
  }
}

Widget customForm(
  String formID,
  String className,
  String shift,
  String room,
  String? dateOpen,
  int typeAttendance,
  String? startTime,
  String? endTime,
) {
  return Container(
    width: 380,
    height: 370,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: AppColors.primaryText.withOpacity(0.1), width: 0.2),
        boxShadow: [
          BoxShadow(
              color: AppColors.primaryText.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, 1))
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
              CustomText(
                  message: 'FormID: $formID',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText),
              InkWell(
                  onTap: () {},
                  mouseCursor: SystemMouseCursors.click,
                  child: Icon(Icons.more_vert))
            ],
          ),
          Divider(
            color: AppColors.primaryText.withOpacity(0.2),
            thickness: 0.5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  message: 'Class: $className',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  message: 'Shift: $shift - Room: $room',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  message: 'Date: ${dateOpen!}',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  message: typeAttendance == 1
                      ? 'Type: Scan face'
                      : 'Type: Check in class',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomText(
                      message: 'StartTime: ${startTime!}',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText),
                  const SizedBox(
                    width: 50,
                  ),
                  CustomText(
                      message: 'EndTime: ${endTime!}',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  message: 'Push Notification to everyone: ON',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: CustomButton(
                    buttonName: 'Edit',
                    backgroundColorButton:
                        AppColors.primaryButton.withOpacity(0.7),
                    borderColor: Colors.white,
                    textColor: Colors.white,
                    function: () {},
                    height: 30,
                    width: 185,
                    fontSize: 12,
                    colorShadow: Colors.transparent,
                    borderRadius: 5),
              )
            ],
          )
        ],
      ),
    ),
  );
}
