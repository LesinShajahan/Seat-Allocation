import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seat_allocation/view/Adminhome.dart';

class AddDepartmentHome extends StatefulWidget {
  const AddDepartmentHome({super.key});

  @override
  State<AddDepartmentHome> createState() => _AddDepartmentHomeState();
}

class _AddDepartmentHomeState extends State<AddDepartmentHome> {
  //text controllers
  final user = FirebaseAuth.instance.currentUser;

  final TextEditingController departmentController = TextEditingController();
  @override
  void dispose() {
    departmentController.dispose();

    super.dispose();
  }

  Future adddepartmentdetails(String department) async {
    await FirebaseFirestore.instance
        .collection('departmentdetails')
        .doc(department) // Use department name as document ID
        .set({
      'department': department,
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 19, 57, 85),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminHome(),
                ));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 19, 57, 85),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "ADD DEPARTMENT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: departmentController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'DEPARTMENT',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add logic to handle form submission
                  String department = departmentController.text.trim();

                  // Check if the department is not empty before saving
                  if (department.isNotEmpty) {
                    adddepartmentdetails(department);
                    // Optionally, you can add navigation or show a success message here
                  } else {
                    // Handle the case when the department is empty
                    // You might want to display an error message or take appropriate action
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
