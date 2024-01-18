import 'package:flutter/material.dart';
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
      body: FutureBuilder(
          future: API().getClassForTeacher('222h333'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return Text('Have data: ${snapshot.data!.first.shiftNumber}');
              }
            }
            return Text('Data is not available');
          }),
    );
  }
}
