import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/attendanceForm_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/class_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/edit_attendance_detail_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/edit_attendance_form_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/selected_page_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/socketServer_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/studentClasses_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/teacher_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/Home/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AttendanceFormDataProvider()),
    ChangeNotifierProvider(create: (_) => SocketServerProvider()),
    ChangeNotifierProvider(create: (_) => StudentClassesDataProvider()),
    ChangeNotifierProvider(create: (_) => ClassDataProvider()),
    ChangeNotifierProvider(create: (_) => TeacherDataProvider()),
    ChangeNotifierProvider(create: (_) => SelectedPageProvider()),
    ChangeNotifierProvider(create: (_) => EditAttendanceDetailProvider()),
    ChangeNotifierProvider(create: (_) => EditAttendanceFormProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  //Navigator.pushNamed and create a routes in main
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
        ),
        debugShowCheckedModeBanner: false,
        title: 'Attendance System Lecturer',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: AppColors.backgroundColor),
          useMaterial3: false,
        ),
        home: HomePage());
  }
}
