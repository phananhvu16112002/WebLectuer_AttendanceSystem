import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/teacher_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/CreateNewPasswordPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/Authentication.dart';

class ForgotPasswordOTP extends StatefulWidget {
  const ForgotPasswordOTP({super.key});

  @override
  State<ForgotPasswordOTP> createState() => _ForgotPasswordOTPState();
}

class _ForgotPasswordOTPState extends State<ForgotPasswordOTP> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  OtpFieldController otpFieldController = OtpFieldController();
  int secondsRemaining = 10; // Initial value for 1 minute
  bool canResend = false;
  late Timer _timer;
  late ProgressDialog _progressDialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    _progressDialog = ProgressDialog(context,
        customBody: Container(
          width: 200,
          height: 150,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
          child: const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppColors.primaryButton,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Loading',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
        ));
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          canResend = true;
        });
        timer.cancel();
      }
    });
  }

  String textDesciption =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged';
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // html.window.history.pushState({}, 'OTP', 'OTP');
    final teacherDataProvider =
        Provider.of<TeacherDataProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color(0xffced9e9),
        body: Center(
            child: Container(
                height: MediaQuery.of(context).size.height - 100,
                width: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 4))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      width: 550,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const CustomText(
                                  message: 'TON DUC THANG UNIVERSITY',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.importantText)
                            ],
                          ),
                          Center(
                            child: Image.asset(
                              'assets/images/forgotPassword.png',
                              width: 300,
                              height: 300,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            height: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                    message:
                                        'Go Digital With Attendance System',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryButton),
                                CustomText(
                                    message: textDesciption,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        AppColors.primaryText.withOpacity(0.5))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      width: 550,
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height - 150,
                          width: 450,
                          decoration: BoxDecoration(
                              color: const Color(0xffb9b9b9).withOpacity(0.06),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                const Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          message:
                                              'Verify OTP to active account',
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryText),
                                      CustomText(
                                          message: 'to continue',
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryText),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                OTPTextField(
                                  controller: otpFieldController,
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  length: 6,
                                  width: MediaQuery.of(context).size.width,
                                  outlineBorderRadius: 10,
                                  fieldWidth: 50,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                  fieldStyle: FieldStyle.box,
                                  onChanged: (pin) {
                                    teacherDataProvider.setOTP(pin);
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: CustomButton(
                                      buttonName: 'Verify',
                                      backgroundColorButton:
                                          AppColors.primaryButton,
                                      borderColor: Colors.white,
                                      textColor: Colors.white,
                                      function: () async {
                                        String checkOTP = await Authenticate()
                                            .verifyForgotPassword(
                                                teacherDataProvider
                                                    .userData.teacherEmail,
                                                teacherDataProvider
                                                    .userData.teacherHashedOTP);
                                        if (checkOTP == '') {
                                          // ignore: use_build_context_synchronously
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  const CreateNewPasswordPage(),
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 1000),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                var curve =
                                                    Curves.easeInOutCubic;
                                                var tween = Tween(
                                                        begin: const Offset(
                                                            1.0, 0.0),
                                                        end: Offset.zero)
                                                    .chain(CurveTween(
                                                        curve: curve));
                                                var offsetAnimation =
                                                    animation.drive(tween);
                                                return SlideTransition(
                                                  position: offsetAnimation,
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                          await _progressDialog.hide();
                                        } else {
                                          if (mounted) {
                                            await _showDialog(context,
                                                'OTP is not valid', 'Error');
                                            await _progressDialog.hide();
                                          }
                                        }
                                      },
                                      height: 50,
                                      width: 200,
                                      fontSize: 15,
                                      colorShadow: Colors.white,
                                      borderRadius: 10),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CustomText(
                                        message: "Didn't recive code ? ",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryText),
                                    InkWell(
                                      onTap: () async {
                                        if (canResend) {
                                          // Start the countdown timer
                                          print('alo alo');
                                          _progressDialog.show();
                                          bool check = await Authenticate()
                                              .resendOTPForgotPassword(
                                                  teacherDataProvider
                                                      .userData.teacherEmail);
                                          if (check) {
                                            print('sucess');
                                            // ignore: use_build_context_synchronously
                                            await _showDialog(
                                                context,
                                                'OTP has been sent your email',
                                                'Success');
                                          } else {
                                            print('failed');
                                            // ignore: use_build_context_synchronously
                                            await _showDialog(
                                                context,
                                                'Failed to resend OTP',
                                                'Error');
                                          }

                                          restartTimer();
                                          await _progressDialog.hide();
                                        }
                                      },
                                      mouseCursor: SystemMouseCursors.click,
                                      child: CustomText(
                                          message: canResend
                                              ? "Re-send"
                                              : "Resend in $secondsRemaining seconds",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.importantText),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ))));
  }

  Container customTextFormField(
      TextEditingController controller,
      TextInputType textInputType,
      String labelText,
      IconButton suffixIcon,
      Icon prefixIcon) {
    return Container(
      width: 420,
      height: 50,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        readOnly: false,
        controller: controller,
        keyboardType: textInputType,
        style: const TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.normal,
            fontSize: 15),
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            labelText: labelText,
            labelStyle: const TextStyle(
                fontSize: 12, color: Color.fromARGB(73, 0, 0, 0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(width: 1, color: Colors.black.withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              borderSide:
                  BorderSide(width: 1, color: Colors.black.withOpacity(0.5)),
            )),
      ),
    );
  }

  Future<dynamic> _showDialog(
      BuildContext context, String errorMessage, String title) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(title),
            content: Text(
              errorMessage,
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // if (errorMessage == 'OTP has been resent to email') {
                  //   restartTimer();
                  // }
                },
              ),
            ],
          );
        });
  }

  void restartTimer() {
    setState(() {
      secondsRemaining = 10;
      canResend = false;
    });
    startTimer(); // Start the timer again
  }
}
