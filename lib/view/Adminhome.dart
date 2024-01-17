import 'package:flutter/material.dart';
import 'package:seat_allocation/view/addstudentdetails.dart';
import 'package:seat_allocation/view/addteacherdetails.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 57, 85),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Add your menu icon onPressed logic here
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add your notification icon onPressed logic here
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://example.com/user_profile_image.jpg'),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(300, 0),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTeacherHome(),
                    ));
              },
              child: Text(
                "ADD TEACHERS",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddstudentHome(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 19, 57, 85),
                  fixedSize: Size(300, 0),
                ),
                child: Text(
                  "ADD STUDENT",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "ADD DEPARTMENT" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(300, 0),
              ),
              // style: ElevatedButton.styleFrom(
              //   primary: Color.fromARGB(255, 19, 57, 85),
              // ),
              child: Text(
                "ADD DEPARTMENT",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "SEAT ALLOCATION" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(300, 0),
              ),
              child: Text(
                "SEAT ALLOCATION",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "ADD EXAM HALLS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(300, 0),
              ),
              child: Text(
                "ADD EXAM HALLS",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "VIEW SEATING ARRANGEMENTS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(300, 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "VIEW SEATING ARRANGEMENTS",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "STUDENTS DETAILS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(300, 0),
              ),
              child: Text(
                "STUDENTS DETAILS",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "TEACHER DETAILS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(300, 0),
              ),
              child: Text(
                "TEACHER DETAILS",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "VIEW DEPARTMENTS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(300, 0),
              ),
              child: Text(
                "VIEW DEPARTMENTS",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "VIEW EXAMHALLS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(300, 0),
              ),
              child: Text(
                "VIEW EXAMHALLS",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "EDIT DETAILS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(300, 0),
              ),
              child: Text(
                "EDIT DETAILS",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your logout button onPressed logic here
        },
        child: Icon(Icons.logout),
        backgroundColor: Color.fromARGB(
            255, 19, 57, 85), // You can change the color as per your preference
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
