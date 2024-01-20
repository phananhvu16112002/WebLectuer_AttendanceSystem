import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';

class AfterCreateAttendanceForm extends StatefulWidget {
  const AfterCreateAttendanceForm({super.key});

  @override
  State<AfterCreateAttendanceForm> createState() =>
      _AfterCreateAttendanceFormState();
}

class _AfterCreateAttendanceFormState extends State<AfterCreateAttendanceForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const CustomText(
                message: 'After Create Forms',
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryText),
            const SizedBox(
              height: 10,
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
