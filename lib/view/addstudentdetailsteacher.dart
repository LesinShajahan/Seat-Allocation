import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seat_allocation/view/teacherhome.dart';

class AddstudentHomeTeacher extends StatefulWidget {
  const AddstudentHomeTeacher({Key? key}) : super(key: key);

  @override
  State<AddstudentHomeTeacher> createState() => _AddstudentHomeState();
}

class _AddstudentHomeState extends State<AddstudentHomeTeacher> {
  //text controllers
  final TextEditingController registrationnumberController =
      TextEditingController();
  final TextEditingController studentnameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateofbirthController = TextEditingController();

  @override
  void dispose() {
    registrationnumberController.dispose();
    studentnameController.dispose();
    departmentController.dispose();
    yearController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dateofbirthController.dispose();

    super.dispose();
  }

  Future<void> signUp() async {
    //create user
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());

    //add user details
    addStudentdetails(
        registrationnumberController.text.trim(),
        studentnameController.text.trim(),
        departmentController.text.trim(),
        int.parse(yearController.text.trim()),
        emailController.text.trim(),
        passwordController.text.trim(),
        dateofbirthController.text.trim());
  }

  Future<void> addStudentdetails(
      String registrationnumber,
      String studentname,
      String department,
      int year,
      String email,
      String password,
      String dateofbirth) async {
    // Query Firestore to check if a student with the same registration number already exists
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('studentsdetails')
        .where('registration number', isEqualTo: registrationnumber)
        .get();

    // If there are no documents matching the query, add the student details
    if (querySnapshot.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection(
              'studentsdetails') // Assuming 'studentsdetails' is the collection name
          .doc(studentname) // Set the document ID as the student name
          .set({
        'registration number': registrationnumber,
        'student name': studentname,
        'department': department,
        'year': year,
        'email': email,
        'password': password,
        'date of birth': dateofbirth,
      });

      // Clear text controllers after successful submission
      registrationnumberController.clear();
      studentnameController.clear();
      departmentController.clear();
      yearController.clear();
      emailController.clear();
      passwordController.clear();
      dateofbirthController.clear();

      // Optionally, you can show a snackbar or navigate to another screen upon successful submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Student details submitted successfully!'),
        ),
      );
    } else {
      // If a student with the same registration number already exists, display a message indicating that
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Student with this registration number already exists!'),
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
                builder: (context) => TeacherHome(),
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
                    "ADD STUDENT DETAILS",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: registrationnumberController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Registration Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: studentnameController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Student Name',
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
                controller: yearController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Year',
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
                  signUp(); // Call the signUp method to store data in Firebase
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
