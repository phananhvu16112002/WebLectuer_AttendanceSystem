import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/home_page/Semester.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/home_page/class_data_home_page.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';

class RepositoryClassPage extends StatefulWidget {
  const RepositoryClassPage({super.key});

  @override
  State<RepositoryClassPage> createState() => _RepositoryClassPageState();
}

class _RepositoryClassPageState extends State<RepositoryClassPage> {
  int? selectedSemesterID;
  List<Semester> semesters = [];
  String dropdownvalue = '';
  late Future<List<Semester>> _fetchSemester;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSemester();
  }

  void fetchSemester() async {
    _fetchSemester = API(context).getSemester();
    _fetchSemester.then((value) {
      setState(() {
        semesters = value;
        if (semesters.isNotEmpty) {
          dropdownvalue = semesters.first.semesterName ?? '';
          selectedSemesterID = semesters.first.semesterID;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
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
            Row(
              children: [
                CustomText(
                    message: 'Select semester',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: AppColors.primaryText.withOpacity(0.2))),
                  child: DropdownButton<String>(
                    focusColor: Colors.transparent,
                    underline: Container(),
                    value: dropdownvalue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                      selectedSemesterID = semesters
                          .firstWhere(
                              (semester) => semester.semesterName == newValue)
                          .semesterID;
                    },
                    iconSize: 15,
                    menuMaxHeight: 150,
                    style: TextStyle(fontSize: 15),
                    items: semesters
                        .map<DropdownMenuItem<String>>((Semester value) {
                      return DropdownMenuItem<String>(
                        value: value.semesterName,
                        child: Text(value.semesterName ?? ''),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: API(context).getClasses(page, selectedSemesterID, true),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    ClassDataHomePage? classesData = snapshot.data;
                    // Future.delayed(Duration.zero, () {
                    //   classDataProvider.setAttendanceFormData(classes!);
                    // });
                    return Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 16 / 9,
                                  mainAxisSpacing: 15),
                          itemCount: classesData?.classes?.length ?? 0,
                          itemBuilder: (context, index) {
                            Class data =
                                classesData?.classes?[index] ?? Class();
                            var randomBanner = Random().nextInt(2);
                            return InkWell(
                              onTap: () {},
                              mouseCursor: SystemMouseCursors.click,
                              child: customClass(
                                  data.classID ?? '',
                                  data.course?.courseName ?? '',
                                  data.classType ?? '',
                                  data.group ?? '',
                                  data.subGroup ?? '',
                                  data.shiftNumber ?? 0,
                                  data.roomNumber ?? '',
                                  'assets/images/banner$randomBanner.jpg',
                                  150),
                            );
                          },
                        ),
                        _buildPaginationButtons(classesData?.totalPage ?? 1),
                      ],
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryButton));
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              'assets/images/nodata.png',
                              width: 200,
                              height: 200,
                            )),
                        const SizedBox(height: 5),
                        CustomText(
                            message: 'No Class',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText.withOpacity(0.3))
                      ],
                    ),
                  );
                }
                return const Center(child: Text('Data is not available'));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget customClass(
    String classID,
    String className,
    String typeClass,
    String group,
    String subGroup,
    int shiftNumber,
    String room,
    String imgPath,
    double height,
  ) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: const Offset(0, 5),
            color: Colors.black.withOpacity(0.1),
          )
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                SizedBox(
                  height: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      imgPath,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        className,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Group: $group - Sub: $subGroup | ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Type: $typeClass',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Shift: $shiftNumber | ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Room: $room',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    onSelected: (value) {},
                    itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          value: '/restore',
                          child: Text("Restore"),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm restore'),
                                  content: Text(
                                      'Are you sure you want to restore this class?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () async {
                                        bool result = await API(context)
                                            .repositoryClassbyID(classID, false);
                                        if (result) {
                                          Navigator.of(context).pop();
                                          _customDialog('Repository',
                                              'Restore class successfully');
                                        } else {
                                          Navigator.of(context).pop();
                                          _customDialog('Repository',
                                              'Restore class failed');
                                        }
                                        // Perform your deactivation logic here
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),       
                      ];
                    },
                  ),
                )
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_2_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.document_scanner_outlined),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPaginationButtons(int totalPage) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: page > 1
              ? () {
                  setState(() {
                    page--;
                  });
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey.withOpacity(0.2);
                }
                return null; // Màu mặc định khi không bị vô hiệu hóa
              },
            ),
          ),
          child: const Text(
            'Previous',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        CustomText(
          message: '$page/$totalPage',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: page < totalPage
              ? () {
                  setState(() {
                    page++;
                  });
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey.withOpacity(0.2);
                }
                return null;
              },
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _customDialog(String title, String subTitle) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subTitle),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                // Perform your deactivation logic here
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
