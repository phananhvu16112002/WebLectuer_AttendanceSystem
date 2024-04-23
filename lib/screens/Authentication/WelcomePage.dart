import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/SignInPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/Responsive.dart';

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
    // html.window.history.pushState({}, 'Welcome', 'Welcome');
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffced9e9),
      body: Responsive(
        mobile: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          // height: 400,
                          // width: 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  message: 'Welcome To ',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      AppColors.primaryButton.withOpacity(0.6)),
                              CustomText(
                                  message: 'Attendance System ',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      AppColors.primaryButton.withOpacity(0.8)),
                              const Divider(
                                color: AppColors.primaryButton,
                                endIndent: 100,
                                thickness: 3,
                              ),
                              CustomText(
                                  message: textDesciption,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      AppColors.primaryButton.withOpacity(0.8)),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                  buttonName: 'Get Started',
                                  backgroundColorButton:
                                      AppColors.primaryButton,
                                  borderColor: Colors.transparent,
                                  textColor: Colors.white,
                                  function: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const SignInPage()));
                                  },
                                  height: 55,
                                  width: 120,
                                  fontSize: 14,
                                  colorShadow: Colors.white,
                                  borderRadius: 10)
                            ],
                          ),
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: _imageWelcome(size),
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        tablet: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _content(context),
                    ),
                    Expanded(
                      flex: 1,
                      child: _imageWelcome(size),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        desktop: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: _content(context),
                        ),
                        Expanded(
                          flex: 1,
                          child: _imageWelcome(size),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _content(BuildContext context) {
    return SizedBox(
      // height: 400,
      // width: 500,
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
                        builder: (builder) => const SignInPage()));
              },
              height: 50,
              width: 120,
              fontSize: 15,
              colorShadow: Colors.white,
              borderRadius: 10)
        ],
      ),
    );
  }

  SizedBox _imageWelcome(Size size) {
    return SizedBox(
      height: size.width > 1500 ? 380 : 380,
      width: convertSize(size),
      child: Image.asset(
        'assets/images/welcomePage.png',
        fit: BoxFit.fitHeight,
      ),
    );
  }

  double convertSize(Size size) {
    if (size.width < 500) {
      return 200;
    } else if (size.width > 1500) {
      return 600;
    } else {
      return 500;
    }
  }
}
