import 'package:flutter/material.dart';

class AddstudentHome extends StatelessWidget {
  const AddstudentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 57, 85),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 19, 57, 85),
              ),
              child: Center(
                child: Text(
                  "Add Student Details",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Registration Number'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Student Name'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Department'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Year'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to handle form submission
                // You can access the entered values using the controllers of each TextFormField
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
