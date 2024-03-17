import 'package:flutter/material.dart';
import 'package:seat_allocation/view/adddepartment.dart';
import 'package:seat_allocation/view/addexamhalls.dart';
import 'package:seat_allocation/view/addstudentdetailsforadmin.dart';
import 'package:seat_allocation/view/addteacherdetails.dart';
import 'package:seat_allocation/view/seatallocation.dart';
import 'package:seat_allocation/view/viewdepartments.dart';
import 'package:seat_allocation/view/viewexamhalls.dart';
import 'package:seat_allocation/view/viewstudentdetailsAdmin.dart';
import 'package:seat_allocation/view/viewteacherdetails.dart';
import 'package:seat_allocation/view/welcomePage.dart';

class AdminHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 57, 85),
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            // Add your menu icon onPressed logic here
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.white,
            onPressed: () {
              // Add your notification icon onPressed logic here
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.ibb.co/P9X3m82/Whats-App-Image-2024-03-12-at-10-14-01-AM.jpg'),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 19, 57, 85),
              ),
              child: Text(
                'Menu Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Menu Item 1'),
              onTap: () {
                // Add your logic for menu item 1
              },
            ),
            ListTile(
              title: Text('Menu Item 2'),
              onTap: () {
                // Add your logic for menu item 2
              },
            ),
            // Add more ListTile widgets for additional menu items
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDepartmentHome(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 19, 57, 85),
                      fixedSize: Size(300, 0),
                    ),
                    child: Text(
                      "ADD DEPARTMENT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add your "SEAT ALLOCATION" button onPressed logic here
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeatAllocation(),
                          ));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddExamhall(),
                          ));
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
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddExamhall(),
                            ));
                      };
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewStudents()),
                      );
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewTeachers(),
                          ));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewDepartments(),
                          ));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewExamhalls(),
                          ));
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
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WelcomePage()),
          );
        },
        child: Icon(Icons.logout),
        backgroundColor: Color.fromARGB(255, 19, 57, 85),
        foregroundColor: Colors.white,
        // You can change the color as per your preference
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
