import 'package:flutter/material.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({Key? key}) : super(key: key);

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
              // Add user details here, e.g., user profile image
              backgroundImage:
                  NetworkImage('https://example.com/user_profile_image.jpg'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            width: 380,
            height: 36,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 19, 57,
                  85), // You can change the color as per your preference
            ),
            child: Center(
              child: Text(
                'My Exam Hall',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30), // Adjust the spacing as needed
          const Placeholder(),
        ],
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