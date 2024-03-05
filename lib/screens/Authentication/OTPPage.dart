import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<OTPPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  OtpFieldController otpFieldController = OtpFieldController();

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
                              'assets/images/OTPPage.png',
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
                                  onChanged: (pin) {},
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
                                      function: () {},
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
                                      onTap: () {},
                                      mouseCursor: SystemMouseCursors.click,
                                      child: const CustomText(
                                          message: 'Re-send',
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
}
