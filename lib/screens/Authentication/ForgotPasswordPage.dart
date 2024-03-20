import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/teacher_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/ForgotPasswordOTP.dart';

import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/SignInPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/Authentication.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ProgressDialog _progressDialog;
  String textDesciption =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    // html.window.history.pushState({}, 'ForgotPassword', 'ForgotPassword');
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
                                          message: 'Forgot your password ?',
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryText),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const CustomText(
                                              message: 'Email',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryText),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          customTextFormField(
                                              emailController,
                                              TextInputType.emailAddress,
                                              'Enter your email',
                                              const IconButton(
                                                  onPressed: null,
                                                  icon: Icon(null)),
                                              false,
                                              validateTextField, (value) {
                                            teacherDataProvider
                                                .setTeacherEmail(value);
                                          },
                                              Icon(Icons.email_outlined,
                                                  color: AppColors.primaryText
                                                      .withOpacity(0.5))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: CustomButton(
                                      buttonName: 'Send',
                                      backgroundColorButton:
                                          AppColors.primaryButton,
                                      borderColor: Colors.white,
                                      textColor: Colors.white,
                                      function: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _progressDialog.show();
                                          String result = await Authenticate()
                                              .forgotPassword(
                                                  emailController.text);
                                          if (result == '') {
                                            // ignore: use_build_context_synchronously
                                            await Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    const ForgotPasswordOTP(),
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
                                            await _showDialog(context, result);
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
                                        message: "Already have an account ? ",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryText),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    SignInPage()));
                                      },
                                      mouseCursor: SystemMouseCursors.click,
                                      child: const CustomText(
                                          message: 'Login',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.importantText),
                                    ),
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

  Future<dynamic> _showDialog(BuildContext context, String errorMessage) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
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
                },
              ),
            ],
          );
        });
  }

  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    return null;
  }

  Container customTextFormField(
      TextEditingController controller,
      TextInputType textInputType,
      String labelText,
      IconButton suffixIcon,
      bool obscureText,
      String? Function(String?)? validator,
      Function(String)? onChanged,
      Icon prefixIcon) {
    return Container(
      width: 420,
      // height: 50,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        readOnly: false,
        controller: controller,
        keyboardType: textInputType,
        style: const TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.normal,
            fontSize: 15),
        obscureText: obscureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(width: 1, color: Colors.black.withOpacity(0.2))),
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
}
