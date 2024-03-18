import 'dart:async';
import 'package:flutter/material.dart';
import 'package:seat_allocation/view/welcomePage.dart';
// Replace this with your desired landing page

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 6), // Change the duration as needed
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  WelcomePage()), // Replace LoginPage with your desired landing page
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png', // Path to your logo image
              width: 150, // Adjust width as needed
            ),
            SizedBox(height: 10),
            Text(
              'SEAT ALLOCATION', // Replace with your app's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Your Stress-Free Exam Companion', // Add your stress-free message here
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey, // Customize the color if needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
