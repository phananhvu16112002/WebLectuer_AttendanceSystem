import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomRichText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';

class EditAttendanceDetail extends StatefulWidget {
  const EditAttendanceDetail({super.key});

  @override
  State<EditAttendanceDetail> createState() => _EditAttendanceDetailState();
}

class _EditAttendanceDetailState extends State<EditAttendanceDetail> {
  TextEditingController topicController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  String selectedValue = 'Lectuer take attendance';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  message: 'Edit',
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 390,
                    height: 550,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: AppColors.primaryText.withOpacity(0.1),
                            width: 0.5),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.primaryText.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 1))
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                      message: 'Details',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryText),
                                  Container(
                                    width: 65,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: chooseColor('Present'),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
                                    child: const Center(
                                      child: CustomText(
                                          message: 'Present',
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 390,
                            color: const Color(0xfff6f9ff),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 20),
                              child: CustomText(
                                  message: 'Basic Details',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryText),
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 390,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 260,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 20,
                                        bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customRichText(
                                          title: 'First Name: ',
                                          message: 'Phan Anh',
                                          fontWeightTitle: FontWeight.w600,
                                          fontWeightMessage: FontWeight.normal,
                                          colorText: AppColors.primaryText
                                              .withOpacity(0.3),
                                          fontSize: 12,
                                          colorTextMessage:
                                              AppColors.primaryText,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        customRichText(
                                          title: 'StudentID: ',
                                          message: '520H0696',
                                          fontWeightTitle: FontWeight.w600,
                                          fontWeightMessage: FontWeight.normal,
                                          colorText: AppColors.primaryText
                                              .withOpacity(0.3),
                                          fontSize: 12,
                                          colorTextMessage:
                                              AppColors.primaryText,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        customRichText(
                                          title: 'Mail: ',
                                          message:
                                              '520H0696@student.tdtu.edu.vn',
                                          fontWeightTitle: FontWeight.w600,
                                          fontWeightMessage: FontWeight.normal,
                                          colorText: AppColors.primaryText
                                              .withOpacity(0.3),
                                          fontSize: 12,
                                          colorTextMessage:
                                              AppColors.primaryText,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        customRichText(
                                          title: 'Class: ',
                                          message: 'Introduction to Networking',
                                          fontWeightTitle: FontWeight.w600,
                                          fontWeightMessage: FontWeight.normal,
                                          colorText: AppColors.primaryText
                                              .withOpacity(0.3),
                                          fontSize: 12,
                                          colorTextMessage:
                                              AppColors.primaryText,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        customRichText(
                                          title: 'Shift - Room:  ',
                                          message: '3 - A0503',
                                          fontWeightTitle: FontWeight.w600,
                                          fontWeightMessage: FontWeight.normal,
                                          colorText: AppColors.primaryText
                                              .withOpacity(0.3),
                                          fontSize: 12,
                                          colorTextMessage:
                                              AppColors.primaryText,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customRichText(
                                          title: 'Last Name: ',
                                          message: 'Vu',
                                          fontWeightTitle: FontWeight.w600,
                                          fontWeightMessage: FontWeight.normal,
                                          colorText: AppColors.primaryText
                                              .withOpacity(0.3),
                                          fontSize: 12,
                                          colorTextMessage:
                                              AppColors.primaryText,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        customRichText(
                                          title: 'Gender: ',
                                          message: 'Male',
                                          fontWeightTitle: FontWeight.w600,
                                          fontWeightMessage: FontWeight.normal,
                                          colorText: AppColors.primaryText
                                              .withOpacity(0.3),
                                          fontSize: 12,
                                          colorTextMessage:
                                              AppColors.primaryText,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        customRichText(
                                          title: 'Course ',
                                          message: '24',
                                          fontWeightTitle: FontWeight.w600,
                                          fontWeightMessage: FontWeight.normal,
                                          colorText: AppColors.primaryText
                                              .withOpacity(0.3),
                                          fontSize: 12,
                                          colorTextMessage:
                                              AppColors.primaryText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 390,
                            color: const Color(0xfff6f9ff),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 20),
                              child: CustomText(
                                  message: 'Eividence of the problem',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryText),
                            ),
                          ),
                          Container(
                              width: 390,
                              height: 335,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: 350,
                                  height: 300,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      width: 260,
                      height: 550,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: AppColors.primaryText.withOpacity(0.1),
                              width: 0.2),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.primaryText.withOpacity(0.2),
                                blurRadius: 2,
                                offset: const Offset(0, 1))
                          ]),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                                message: 'FeedBack',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText),
                            Container(
                              height: 30,
                              child: TextFormField(
                                readOnly: true,
                                enabled: false,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(53, 226, 240, 253),
                                    disabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    label: customRichText(
                                        title: 'To: ',
                                        message: "Phan Anh Vu",
                                        fontWeightTitle: FontWeight.normal,
                                        fontWeightMessage: FontWeight.normal,
                                        colorText: AppColors.primaryText
                                            .withOpacity(0.2),
                                        fontSize: 12,
                                        colorTextMessage: AppColors.primaryText
                                            .withOpacity(0.5))),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              child: SingleChildScrollView(
                                child: TextFormField(
                                  controller: topicController,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.primaryText),
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.primaryText
                                              .withOpacity(0.2)),
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          53, 226, 240, 253),
                                      disabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      hintText: 'Topic'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(53, 226, 240, 253),
                              ),
                              child: DropdownButton<String>(
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                                items: <String>[
                                  'Lectuer take attendance',
                                  'Deny attendance'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.primaryText,
                                ),
                                underline: Container(),
                                isExpanded: true,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 320,
                              width: 280,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(53, 226, 240, 253)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.primaryText),
                                  controller: messageController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Message',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomButton(
                                buttonName: 'Send',
                                backgroundColorButton: AppColors.primaryButton,
                                borderColor: Colors.transparent,
                                textColor: Colors.white,
                                function: () {},
                                height: 35,
                                width: 260,
                                fontSize: 15,
                                colorShadow:
                                    AppColors.primaryButton.withOpacity(0.7),
                                borderRadius: 5)
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 280,
                    height: 550,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: AppColors.primaryText.withOpacity(0.1),
                            width: 0.2),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.primaryText.withOpacity(0.2),
                              blurRadius: 2,
                              offset: const Offset(0, 1))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                    message: 'Recent Feedbacks',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryText),
                                CustomButton(
                                    buttonName: 'View All',
                                    backgroundColorButton:
                                        const Color.fromARGB(68, 190, 188, 188),
                                    borderColor: Colors.transparent,
                                    textColor: AppColors.primaryText,
                                    function: () {},
                                    height: 15,
                                    width: 45,
                                    fontSize: 8,
                                    colorShadow: Colors.transparent,
                                    borderRadius: 2)
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                    message: '#12346 Responed to Phan Anh Vu ',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.primaryText),
                                Container(
                                  width: 50,
                                  height: 15,
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: const Center(
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                    message: '#12346 Responed to Phan Anh Vu ',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.primaryText),
                                Container(
                                  width: 50,
                                  height: 15,
                                  decoration: const BoxDecoration(
                                      color: AppColors.importantText,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: const Center(
                                    child: Text(
                                      'Denied',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color chooseColor(String status) {
  if (status == 'Present' || status.contains('Present')) {
    return Colors.green;
  } else if ((status == 'Absent' || status.contains('Absent'))) {
    return AppColors.importantText;
  } else if ((status == 'Late' || status.contains('Late'))) {
    return const Color.fromARGB(245, 237, 167, 81);
  }
  return AppColors.importantText;
}
