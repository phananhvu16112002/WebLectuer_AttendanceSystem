import 'dart:html';

import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Authentication/SignInPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool checkObscurePassword = true;
  bool checkObscureConfirm = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String textDesciption =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged';
  @override
  Widget build(BuildContext context) {
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
                                'assets/images/registerImage.png',
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
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
                                            message: 'Register your account to',
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
                                    height: 15,
                                  ),
                                  const CustomText(
                                      message: 'Username:',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryText),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  customTextFormField(
                                    usernameController,
                                    TextInputType.text,
                                    'Enter your username',
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(null)),
                                    false,
                                    validateTextField,
                                    Icon(Icons.email_outlined,
                                        color: AppColors.primaryText
                                            .withOpacity(0.5)),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(null)),
                                      false,
                                      validateTextField,
                                      Icon(Icons.email_outlined,
                                          color: AppColors.primaryText
                                              .withOpacity(0.5))),
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
                                              checkObscurePassword =
                                                  !checkObscurePassword;
                                            });
                                          },
                                          icon: Icon(
                                              checkObscurePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility_outlined,
                                              color: Colors.black
                                                  .withOpacity(0.5))),
                                      checkObscurePassword,
                                      validateTextField,
                                      Icon(Icons.password_outlined,
                                          color: AppColors.primaryText
                                              .withOpacity(0.5))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const CustomText(
                                      message: 'Confirm Password:',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryText),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  customTextFormField(
                                      confirmPasswordController,
                                      TextInputType.visiblePassword,
                                      'Confirm Password',
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              checkObscureConfirm =
                                                  !checkObscureConfirm;
                                            });
                                          },
                                          icon: Icon(
                                              checkObscureConfirm
                                                  ? Icons.visibility_off
                                                  : Icons.visibility_outlined,
                                              color: Colors.black
                                                  .withOpacity(0.5))),
                                      checkObscureConfirm,
                                      validateTextField,
                                      Icon(Icons.password_outlined,
                                          color: AppColors.primaryText
                                              .withOpacity(0.5))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: CustomButton(
                                        buttonName: 'Register',
                                        backgroundColorButton:
                                            AppColors.primaryButton,
                                        borderColor: Colors.white,
                                        textColor: Colors.white,
                                        function: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print('Sucessfully');
                                          } else {
                                            print('Failed');
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
                                      CustomText(
                                          message: "Already have an account ? ",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryText),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => SignInPage()));
                                        },
                                        mouseCursor: SystemMouseCursors.click,
                                        child: CustomText(
                                            message: 'Login',
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
                  ),
                ))));
  }

  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
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
      Icon prefixIcon) {
    return Container(
      width: 420,
      height: 50,
      decoration: const BoxDecoration(
          color: Colors.white,
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
            border: InputBorder.none,
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
