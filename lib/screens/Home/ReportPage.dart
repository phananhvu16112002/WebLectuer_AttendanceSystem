import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomRichText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/TestStudentClasses.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String text =
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sit maiores, perferendis suscipit veniam ratione fuga cumque incidunt quam deleniti vitae maxime totam omnis quidem quo consectetur ad? Veniam, harum? Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sit maiores, perferendis suscipit veniam ratione fuga cumque incidunt quam deleniti vitae maxime totam omnis quidem quo consectetur ad? Veniam, harum? Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sit m';
  List<TestStudentClasses> studentList = [
    TestStudentClasses(
        imgPath: 'assets/images/avatar.png',
        studentID: '520H0696',
        name: 'Phan Anh Vu',
        nameClass: 'Cross-Platform Programming'),
    TestStudentClasses(
        imgPath: 'assets/images/avatar.png',
        studentID: '520H0693',
        name: 'Phan Anh Vu3',
        nameClass: 'Phát triển hệ thống thông tin doanh nghiệp'),
    TestStudentClasses(
        imgPath: 'assets/images/avatar.png',
        studentID: '522H222',
        name: 'Phan Anh Vu1',
        nameClass: 'Nhập môn mạng máy tính'),
    TestStudentClasses(
        imgPath: 'assets/images/avatar.png',
        studentID: '522H222',
        name: 'Phan Anh Vu1',
        nameClass: 'Nhập môn mạng máy tính'),
    TestStudentClasses(
        imgPath: 'assets/images/avatar.png',
        studentID: '520H0696',
        name: 'Phan Anh Vu',
        nameClass: 'Cross-Platform Programming'),
    TestStudentClasses(
        imgPath: 'assets/images/avatar.png',
        studentID: '520H0693',
        name: 'Phan Anh Vu3',
        nameClass: 'Phát triển hệ thống thông tin doanh nghiệp'),
    TestStudentClasses(
        imgPath: 'assets/images/avatar.png',
        studentID: '522H222',
        name: 'Phan Anh Vu1',
        nameClass: 'Nhập môn mạng máy tính'),
    TestStudentClasses(
        imgPath: 'assets/images/avatar.png',
        studentID: '522H222',
        name: 'Phan Anh Vu1',
        nameClass: 'Nhập môn mạng máy tính'),
  ];
  String selectedValue = 'Confirm - Present';
  TextEditingController topicController = TextEditingController();
  TextEditingController messageController = TextEditingController();
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
                  message: 'Reports',
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 280,
                    height: 600,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: CustomText(
                                message: 'Students',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Table(
                              columnWidths: const {
                                0: FixedColumnWidth(50),
                                1: FixedColumnWidth(70),
                                2: FixedColumnWidth(70),
                                3: FixedColumnWidth(90),
                              },
                              border: TableBorder.all(
                                  color: AppColors.secondaryText),
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        child: const Center(
                                          child: CustomText(
                                              message: 'Photo',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        child: const Center(
                                          child: CustomText(
                                              message: 'ID',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        child: const Center(
                                          child: CustomText(
                                              message: 'Name',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        child: const Center(
                                          child: CustomText(
                                              message: 'Class',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                for (var student in studentList)
                                  TableRow(
                                    children: [
                                      InkWell(
                                        mouseCursor: SystemMouseCursors.click,
                                        onTap: () {},
                                        child: TableCell(
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 25,
                                              backgroundImage:
                                                  AssetImage(student.imgPath),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        mouseCursor: SystemMouseCursors.click,
                                        child: TableCell(
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            child: CustomText(
                                                message: student.studentID,
                                                fontSize: 11,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        mouseCursor: SystemMouseCursors.click,
                                        child: TableCell(
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            child: CustomText(
                                                message: student.name,
                                                fontSize: 11,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        mouseCursor: SystemMouseCursors.click,
                                        child: TableCell(
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            child: CustomText(
                                                message: student.nameClass,
                                                fontSize: 11,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 390,
                    height: 600,
                    color: Colors.white,
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
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(113, 190, 188, 188),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: const Center(
                                      child: CustomText(
                                          message: 'ID:123456',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.primaryText),
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
                            height: 160,
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
                                  message: 'About Report',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryText),
                            ),
                          ),
                          Container(
                              width: 390,
                              height: 335,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 195,
                                      height: 335,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const CustomText(
                                              message: 'Description',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryText),
                                          Container(
                                            width: 195,
                                            height: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                border: Border.all(
                                                    color: AppColors
                                                        .secondaryText)),
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: CustomText(
                                                    message: text,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        AppColors.primaryText),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Container(
                                      width: 185,
                                      height: 340,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const CustomText(
                                              message:
                                                  'Evidence of the problem',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryText),
                                          Image.asset(
                                            'assets/images/logo.png',
                                            width: 240,
                                            height: 240,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 280,
                    height: 600,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 280,
                            height: 320,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
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
                                          fillColor: const Color.fromARGB(
                                              53, 226, 240, 253),
                                          disabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                          label: customRichText(
                                              title: 'To: ',
                                              message: "Phan Anh Vu",
                                              fontWeightTitle:
                                                  FontWeight.normal,
                                              fontWeightMessage:
                                                  FontWeight.normal,
                                              colorText: AppColors.primaryText
                                                  .withOpacity(0.5),
                                              fontSize: 12,
                                              colorTextMessage: AppColors
                                                  .primaryText
                                                  .withOpacity(0.5))),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 50,
                                    child: SingleChildScrollView(
                                      child: TextFormField(
                                        controller: topicController,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.primaryText),
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Color.fromARGB(
                                                53, 226, 240, 253),
                                            disabledBorder: OutlineInputBorder(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color.fromARGB(
                                          53, 226, 240, 253),
                                    ),
                                    child: DropdownButton<String>(
                                      value: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value!;
                                        });
                                      },
                                      items: <String>[
                                        'Confirm - Present',
                                        'Denied - Absent'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
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
                                    height: 100,
                                    width: 280,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(53, 226, 240, 253)),
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
                                    height: 10,
                                  ),
                                  CustomButton(
                                      buttonName: 'Send',
                                      backgroundColorButton:
                                          AppColors.primaryButton,
                                      borderColor: Colors.transparent,
                                      textColor: Colors.white,
                                      function: () {},
                                      height: 35,
                                      width: 260,
                                      fontSize: 15,
                                      colorShadow: AppColors.primaryButton
                                          .withOpacity(0.5),
                                      borderRadius: 5)
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 280,
                          height: 270,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomText(
                                          message: 'Recent Feedbacks',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryText),
                                      CustomButton(
                                          buttonName: 'View All',
                                          backgroundColorButton:
                                              const Color.fromARGB(
                                                  68, 190, 188, 188),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomText(
                                          message:
                                              '#12346 Responed to Phan Anh Vu ',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.primaryText),
                                      Container(
                                        width: 50,
                                        height: 15,
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: const Center(
                                          child: Text(
                                            'Confirm',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomText(
                                          message:
                                              '#12346 Responed to Phan Anh Vu ',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.primaryText),
                                      Container(
                                        width: 50,
                                        height: 15,
                                        decoration: const BoxDecoration(
                                            color: AppColors.importantText,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: const Center(
                                          child: Text(
                                            'Denied',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8),
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
