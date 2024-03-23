import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/teacher_data_provider.dart';

import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/ForgotPasswordPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/RegisterPage.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/HomePage.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/Authentication.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/SecureStorage.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool checkObscure = true;
  late ProgressDialog _progressDialog;

  String textDesciption =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    // html.window.history.pushState({}, 'Login', 'Login');
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
                child: Form(
                    key: _formKey,
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
                                  'assets/images/loginImage.png',
                                  width: 300,
                                  height: 300,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 100,
                                height: 140,
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
                                        color: AppColors.primaryText
                                            .withOpacity(0.5))
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
                                  color:
                                      const Color(0xffb9b9b9).withOpacity(0.06),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  'Login to your account to',
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryText),
                                          CustomText(
                                              message: 'continue',
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryText),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const CustomText(
                                        message: 'Email:',
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
                                            onPressed: null, icon: Icon(null)),
                                        Icon(Icons.email_outlined,
                                            color: AppColors.primaryText
                                                .withOpacity(0.5)),
                                        false, (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const CustomText(
                                        message: 'Password:',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryText),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    customTextFormField(
                                        passwordController,
                                        TextInputType.visiblePassword,
                                        'Enter your password',
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                checkObscure = !checkObscure;
                                              });
                                            },
                                            icon: Icon(
                                                checkObscure
                                                    ? Icons.visibility_off
                                                    : Icons.visibility_outlined,
                                                color: Colors.black
                                                    .withOpacity(0.5))),
                                        Icon(Icons.password_outlined,
                                            color: AppColors.primaryText
                                                .withOpacity(0.5)),
                                        checkObscure, (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 290),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      const ForgotPasswordPage()));
                                        },
                                        mouseCursor: SystemMouseCursors.click,
                                        child: const CustomText(
                                            message: 'Forgot Password?',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.importantText),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: CustomButton(
                                          buttonName: 'Login',
                                          backgroundColorButton:
                                              AppColors.primaryButton,
                                          borderColor: Colors.white,
                                          textColor: Colors.white,
                                          function: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _progressDialog.show();
                                              String result =
                                                  await Authenticate().login(
                                                      emailController.text,
                                                      passwordController.text);
                                              if (result == '' ||
                                                  result.isEmpty) {
                                                print('Success');
                                                var teacherID =
                                                    await SecureStorage() //520h0380
                                                        .readSecureData(
                                                            'teacherID');
                                                var teacherEmail =
                                                    await SecureStorage() //520h3080@student.tdtu.edu
                                                        .readSecureData(
                                                            'teacherEmail');
                                                var teacherName =
                                                    await SecureStorage()
                                                        .readSecureData(
                                                            'teacherName');
                                                teacherDataProvider
                                                    .setTeacherID(teacherID);
                                                teacherDataProvider
                                                    .setTeacherEmail(
                                                        teacherEmail);
                                                teacherDataProvider
                                                    .setTeacherName(
                                                        teacherName);
                                                if (mounted) {
                                                  await Navigator
                                                      .pushAndRemoveUntil(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          const HomePage(),
                                                      transitionDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  1000),
                                                      transitionsBuilder:
                                                          (context,
                                                              animation,
                                                              secondaryAnimation,
                                                              child) {
                                                        var curve = Curves
                                                            .easeInOutCubic;
                                                        var tween = Tween(
                                                                begin:
                                                                    const Offset(
                                                                        1.0,
                                                                        0.0),
                                                                end:
                                                                    Offset.zero)
                                                            .chain(CurveTween(
                                                                curve: curve));
                                                        var offsetAnimation =
                                                            animation
                                                                .drive(tween);
                                                        return SlideTransition(
                                                          position:
                                                              offsetAnimation,
                                                          child: child,
                                                        );
                                                      },
                                                    ),
                                                    (route) => false,
                                                  );
                                                }

                                                await _progressDialog.hide();
                                              } else {
                                                await _showDialog(
                                                    context, result);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const CustomText(
                                            message: "Don't have an account ? ",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryText),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (builder) =>
                                                        const RegisterPage()));
                                          },
                                          mouseCursor: SystemMouseCursors.click,
                                          child: const CustomText(
                                              message: 'Register',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
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
                    )))));
  }

  Widget _customDialog() {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text(
              'Loading',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, String errorMessage) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
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

  Container customTextFormField(
      TextEditingController controller,
      TextInputType textInputType,
      String labelText,
      IconButton suffixIcon,
      Icon prefixIcon,
      bool obscureText,
      String? Function(String?)? validator) {
    return Container(
      width: 420,
      // height: ,
      decoration: const BoxDecoration(
          // color: Colors.black, 
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
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
            contentPadding: const EdgeInsets.all(20),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            labelText: labelText,
            labelStyle: const TextStyle(
                fontSize: 12, color: Color.fromARGB(73, 0, 0, 0)),
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(width: 1, color: Colors.black.withOpacity(0.2))),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(width: 1, color: Colors.black.withOpacity(0.2))),
            // errorBorder: ,
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    width: 1, color: Colors.black.withOpacity(0.5)))),
      ),
    );
  }
}
