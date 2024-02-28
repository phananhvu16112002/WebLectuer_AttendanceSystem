import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/studentClasses_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder(
          future: API().getStudentClassAttendanceDetail(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {}
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
            } else {
              print('Data is not availible');
            }
            return Text('Null');
          }),
    ));
  }
}
