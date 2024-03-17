import 'package:flutter/material.dart';
import 'package:seat_allocation/view/student%20LoginPage.dart';

// Assuming you have a file named student_login_page.dart for the student login page

class StudentHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  StudentHome({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    // Perform any necessary logout operations here
    // For example, clearing user session, etc.

    // Navigate to the StudentLoginPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 57, 85),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
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
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            width: 380,
            height: 36,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 19, 57, 85),
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
          const SizedBox(height: 30),
          const Placeholder(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _logout(context); // Call the logout function
        },
        child: Icon(Icons.logout),
        backgroundColor: Color.fromARGB(255, 19, 57, 85),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
