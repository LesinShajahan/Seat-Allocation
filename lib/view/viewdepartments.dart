import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seat_allocation/view/Adminhome.dart';

class ViewDepartments extends StatefulWidget {
  ViewDepartments({Key? key}) : super(key: key);

  @override
  State<ViewDepartments> createState() => _ViewDepartmentsState();
}

class _ViewDepartmentsState extends State<ViewDepartments> {
  late Future<QuerySnapshot> departmentFuture;

  void initState() {
    super.initState();
    departmentFuture = fetchDepartment();
  }

  Future<QuerySnapshot> fetchDepartment() async {
    return FirebaseFirestore.instance.collection('departmentdetails').get();
  }

  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: AppBar(
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
              // Add user details here, e.g., user profile image
              backgroundImage: NetworkImage(
                  'https://i.ibb.co/P9X3m82/Whats-App-Image-2024-03-12-at-10-14-01-AM.jpg'),
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
              color: Color.fromARGB(255, 19, 57, 85),
            ),
            child: Center(
              child: Text(
                'Departments List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const SizedBox(height: 30),
          FutureBuilder<QuerySnapshot>(
            future: departmentFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Department Name')),
                      // Add more columns if needed
                    ],
                    rows: documents.map((document) {
                      final data = document.data() as Map<String, dynamic>;
                      return DataRow(cells: [
                        DataCell(Center(child: Text(data['department']))),
                      ]);
                    }).toList(),
                  ),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
