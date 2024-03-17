import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seat_allocation/view/Adminhome.dart';

class AddExamhall extends StatefulWidget {
  const AddExamhall({Key? key}) : super(key: key);

  @override
  State<AddExamhall> createState() => _AddExamhallState();
}

// Text controllers
final TextEditingController hallIdController = TextEditingController();
final TextEditingController capacityController = TextEditingController();

Future<void> addexamhalls(
  String hallId,
  int capacity,
  BuildContext context,
) async {
  // Reference to the document using the hallId
  DocumentReference examHallRef =
      FirebaseFirestore.instance.collection('examhall').doc(hallId);
  try {
    // Check if the exam hall already exists
    DocumentSnapshot documentSnapshot = await examHallRef.get();

    // If the hall doesn't exist, add it to Firestore
    if (!documentSnapshot.exists) {
      await examHallRef.set({
        'hall_id': hallId,
        'capacity': capacity,
      });

      // Clear text fields after submission
      hallIdController.clear();
      capacityController.clear();

      // Show a snackbar upon successful submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exam hall details submitted successfully!'),
        ),
      );
    } else {
      // If the hall already exists, display a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exam hall with this ID already exists!'),
        ),
      );
    }
  } catch (e) {
    // Handle errors here, such as displaying an error message
    print('Error adding exam hall: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred. Please try again later.'),
      ),
    );
  }
}

class _AddExamhallState extends State<AddExamhall> {
  @override
  void dispose() {
    hallIdController.dispose();
    capacityController.dispose();
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
                controller: hallIdController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Hall ID',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: capacityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    labelText: 'Capacity',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String hallId = hallIdController.text.trim();
                  int capacity =
                      int.tryParse(capacityController.text.trim()) ?? 0;

                  if (hallId.isNotEmpty && capacity > 0) {
                    // Call the function to add data to Firebase
                    await addexamhalls(hallId, capacity, context);
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
