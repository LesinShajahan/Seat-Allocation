import 'package:flutter/material.dart';
import 'package:seat_allocation/view/studenthome.dart';
import 'package:seat_allocation/view/teacherhome.dart';
import 'package:seat_allocation/welcomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TeacherHome(),
    );
  }
}
