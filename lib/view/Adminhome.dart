import 'package:flutter/material.dart';

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
                fixedSize: Size(250, 0),
              ),
              onPressed: () {
                // Add your "ADD TEACHERS" button onPressed logic here
              },
              child: Text("ADD TEACHERS"),
            ),
            Container(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  // Add your "ADD STUDENTS" button onPressed logic here
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 19, 57, 85),
                  fixedSize: Size(250, 0),
                ),
                child: Text("ADD STUDENT"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "ADD DEPARTMENT" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(250, 0),
              ),
              // style: ElevatedButton.styleFrom(
              //   primary: Color.fromARGB(255, 19, 57, 85),
              // ),
              child: Text("ADD DEPARTMENT"),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "SEAT ALLOCATION" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(250, 0),
              ),
              child: Text("SEAT ALLOCATION"),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "ADD EXAM HALLS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(250, 0),
              ),
              child: Text("ADD EXAM HALLS"),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "VIEW SEATING ARRANGEMENTS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(250, 0),
              ),
              child: Text("VIEW SEATING ARRANGEMENTS"),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "STUDENTS DETAILS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(250, 0),
              ),
              child: Text("STUDENTS DETAILS"),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "TEACHER DETAILS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(250, 0),
              ),
              child: Text("TEACHER DETAILS"),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "VIEW DEPARTMENTS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(250, 0),
              ),
              child: Text("VIEW DEPARTMENTS"),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "VIEW EXAMHALLS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(250, 0),
              ),
              child: Text("VIEW EXAMHALLS"),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your "EDIT DETAILS" button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 19, 57, 85),
                fixedSize: Size(250, 0),
              ),
              child: Text("EDIT DETAILS"),
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
