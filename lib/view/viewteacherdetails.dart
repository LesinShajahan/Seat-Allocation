import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seat_allocation/view/Adminhome.dart';

class ViewTeachers extends StatefulWidget {
  ViewTeachers({Key? key}) : super(key: key);

  @override
  State<ViewTeachers> createState() => _ViewTeachersState();
}

class _ViewTeachersState extends State<ViewTeachers> {
  late Future<QuerySnapshot> teachersFuture;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    teachersFuture = fetchTeachers();
  }

  Future<QuerySnapshot> fetchTeachers() async {
    return FirebaseFirestore.instance.collection('teacherdetails').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                'Teachers List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          FutureBuilder<QuerySnapshot>(
            future: teachersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Teacher Name')),
                      DataColumn(label: Text('DOB')),
                      DataColumn(label: Text('Dept')),
                      // Add more columns if needed
                    ],
                    rows: documents.map((document) {
                      final data = document.data() as Map<String, dynamic>;
                      return DataRow(cells: [
                        DataCell(Text(data['ID number'])),
                        DataCell(Text(data['teacher name'])),
                        DataCell(Text(data['date of birth'])),
                        DataCell(Text(data['department'])),
                        // Add more cells if needed
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
