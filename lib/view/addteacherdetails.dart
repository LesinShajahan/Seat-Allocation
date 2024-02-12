import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seat_allocation/view/Adminhome.dart';

class AddTeacherHome extends StatefulWidget {
  const AddTeacherHome({Key? key}) : super(key: key);

  @override
  State<AddTeacherHome> createState() => _AddTeacherHomeState();
}

class _AddTeacherHomeState extends State<AddTeacherHome> {
  //text controllers
  final TextEditingController IDnnumberController = TextEditingController();
  final TextEditingController teachernameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateofbirthController = TextEditingController();

  @override
  void dispose() {
    IDnnumberController.dispose();
    teachernameController.dispose();
    departmentController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dateofbirthController.dispose();

    super.dispose();
  }

  Future signUp() async {
    //create user
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());

    //add user details
    addTeacherdetails(
        IDnnumberController.text.trim(),
        teachernameController.text.trim(),
        departmentController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        dateofbirthController.text.trim());
  }

  Future<void> addTeacherdetails(
      String IDnnumber,
      String teachername,
      String department,
      String email,
      String password,
      String dateofbirth) async {
    // Query Firestore to check if a teacher with the same ID number already exists
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teacherdetails')
        .where('ID number', isEqualTo: IDnnumber)
        .get();

    // If there are no documents matching the query, add the teacher details
    if (querySnapshot.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('teacherdetails').add({
        'ID number': IDnnumber,
        'teacher name': teachername,
        'department': department,
        'email': email,
        'password': password,
        'date of birth': dateofbirth,
      });

      // Optionally, you can show a snackbar or navigate to another screen upon successful submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Teacher details submitted successfully!'),
        ),
      );
    } else {
      // If a teacher with the same ID number already exists, display a message indicating that
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Teacher with this ID number already exists!'),
        ),
      );
    }
  }

  @override
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
              ),
            );
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
                    "ADD TEACHER DETAILS",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: IDnnumberController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'ID Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: teachernameController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Teacher Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: departmentController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Department',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: dateofbirthController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  signUp();
                  // Add logic to handle form submission
                  // You can access the entered values using the controllers of each TextFormField
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
