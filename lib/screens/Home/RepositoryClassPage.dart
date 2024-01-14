import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';

class RepositoryClassPage extends StatefulWidget {
  const RepositoryClassPage({super.key});

  @override
  State<RepositoryClassPage> createState() => _RepositoryClassPageState();
}

class _RepositoryClassPageState extends State<RepositoryClassPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      color: Colors.pink,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const CustomText(
                message: 'Repository Class',
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
