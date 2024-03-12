import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seat_allocation/firebase_options.dart';
import 'package:seat_allocation/view/Adminhome.dart';
import 'package:seat_allocation/view/adddepartment.dart';
import 'package:seat_allocation/view/addexamhalls.dart';
import 'package:seat_allocation/view/addstudentdetails.dart';
import 'package:seat_allocation/view/addteacherdetails.dart';
import 'package:seat_allocation/view/loginpage_admin.dart';
import 'package:seat_allocation/view/loginpage_teacher.dart';
import 'package:seat_allocation/view/main_page.dart';
import 'package:seat_allocation/view/studenthome.dart';
import 'package:seat_allocation/view/teacherhome.dart';
import 'package:seat_allocation/view/viewstudentdetails.dart';
import 'package:seat_allocation/view/welcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
