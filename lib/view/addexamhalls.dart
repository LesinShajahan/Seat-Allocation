import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seat_allocation/view/Adminhome.dart';

class AddExamhall extends StatefulWidget {
  const AddExamhall({super.key});

  @override
  State<AddExamhall> createState() => _AddExamhallState();
}

//text controllers
final user = FirebaseAuth.instance.currentUser;

final TextEditingController hallnameController = TextEditingController();
final TextEditingController blocknameController = TextEditingController();
final TextEditingController floorController = TextEditingController();
final TextEditingController seatingcapacityController = TextEditingController();

Future<void> addexamhalls(
  String hallname,
  String blockname,
  String floor,
  int seatingcapacity,
  BuildContext context,
) async {
  // Query Firestore to check if the exam hall already exists
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('examhall')
      .where('hallname', isEqualTo: hallname)
      .where('blockname', isEqualTo: blockname)
      .get();

  // If there are no documents matching the query, add the exam hall
  if (querySnapshot.docs.isEmpty) {
    await FirebaseFirestore.instance.collection('examhall').add({
      'hallname': hallname,
      'blockname': blockname,
      'floor': floor,
      'seating capacity': seatingcapacity,
    });

    // Clear the text fields after submission
    hallnameController.clear();
    blocknameController.clear();
    floorController.clear();
    seatingcapacityController.clear();

    // Optionally, you can show a snackbar or navigate to another screen upon successful submission
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exam hall details submitted successfully!'),
      ),
    );
  } else {
    // If the exam hall already exists, display a message indicating that
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exam hall already exists!'),
      ),
    );
  }
}

class _AddExamhallState extends State<AddExamhall> {
  @override
  void dispose() {
    hallnameController.dispose();
    blocknameController.dispose();
    floorController.dispose();
    seatingcapacityController.dispose();

    super.dispose();
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
                    "ADD EXAM HALL",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: hallnameController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Hall Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: blocknameController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Block Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: floorController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Floor',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: seatingcapacityController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Seating Capacity',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String hallname = hallnameController.text.trim();
                  String blockname = blocknameController.text.trim();
                  String floor = floorController.text.trim();
                  int seatingCapacity =
                      int.tryParse(seatingcapacityController.text.trim()) ?? 0;

                  if (hallname.isNotEmpty &&
                      blockname.isNotEmpty &&
                      floor.isNotEmpty &&
                      seatingCapacity > 0) {
                    // Call the function to add data to Firebase
                    await addexamhalls(
                        hallname, blockname, floor, seatingCapacity, context);
                  } else {
                    // Show an error message if any of the fields are empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Please fill in all the fields correctly!'),
                      ),
                    );
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
