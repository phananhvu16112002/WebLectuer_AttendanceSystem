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
      body: Container(
        width: 300,
        height: 300,
        child: Image.network('https://i.imgur.com/K1xq8mw.png'),
      ),
    );
  }
}
