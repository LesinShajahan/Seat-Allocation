import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SeatAllocation extends StatefulWidget {
  SeatAllocation({Key? key}) : super(key: key);

  @override
  State<SeatAllocation> createState() => _SeatAllocationState();
}

class _SeatAllocationState extends State<SeatAllocation> {
  TextEditingController hallIdController = TextEditingController();
  String? hallName;
  int? hallcapacity;

  Future<void> fetchHallDetails(String hallId) async {
    try {
      // Query Firestore to fetch the hall details based on the hall ID
      DocumentSnapshot hallSnapshot = await FirebaseFirestore.instance
          .collection('examhall')
          .doc(hallId)
          .get();

      // Check if the hall exists in Firestore
      if (hallSnapshot.exists) {
        // Extract hall details from the snapshot
        Map<String, dynamic> hallData =
            hallSnapshot.data() as Map<String, dynamic>;

        // Update the UI with the fetched details
        setState(() {
          hallcapacity = hallData['capacity'];
          print(hallcapacity);
          // You can add more fields to update the UI
        });
      } else {
        // If the hall does not exist, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hall with ID $hallId does not exist!'),
          ),
        );
      }
    } catch (e) {
      print('Error fetching hall details: $e');
      // Handle errors here, such as displaying an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching hall details: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SEAT ALLOCATION",
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Color.fromARGB(255, 19, 57, 85),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: hallIdController,
              decoration: InputDecoration(labelText: "Hall ID"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                String hallId = hallIdController.text.trim();
                if (hallId.isNotEmpty) {
                  // Fetch hall details from Firestore
                  fetchHallDetails(hallId);
                } else {
                  // Show an error message if hall ID is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a Hall ID!'),
                    ),
                  );
                }
              },
              child: Text("Fetch Details"),
            ),
            SizedBox(height: 20),
            // Display hall details
            if (hallName != null) Text('Hall Name: $hallName'),
            // Add more UI elements to display other hall details as needed
          ],
        ),
      ),
    );
  }
}
