import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/SignInPage.dart';
import 'dart:html' as html;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String textDesciption =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged';
  @override
  Widget build(BuildContext context) {
    html.window.history.pushState({}, 'Welcome', 'Welcome');

    return Scaffold(
      backgroundColor: const Color(0xffced9e9),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width - 100,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(const Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 4))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 45, top: 10),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 400,
                    width: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            message: 'Welcome To ',
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryButton.withOpacity(0.6)),
                        CustomText(
                            message: 'Attendance System ',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryButton.withOpacity(0.8)),
                        const Divider(
                          color: AppColors.primaryButton,
                          endIndent: 100,
                          thickness: 3,
                        ),
                        CustomText(
                            message: textDesciption,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryButton.withOpacity(0.8)),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            buttonName: 'Get Started',
                            backgroundColorButton: AppColors.primaryButton,
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => SignInPage()));
                            },
                            height: 50,
                            width: 120,
                            fontSize: 15,
                            colorShadow: Colors.white,
                            borderRadius: 10)
                      ],
                    ),
                  ),
                  Container(
                    height: 400,
                    width: 500,
                    child: Image.asset(
                      'assets/images/welcomePage.png',
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
