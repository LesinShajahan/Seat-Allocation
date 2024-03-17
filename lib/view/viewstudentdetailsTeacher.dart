import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seat_allocation/view/teacherhome.dart';

class ViewStudentsTeacher extends StatefulWidget {
  ViewStudentsTeacher({Key? key}) : super(key: key);

  @override
  State<ViewStudentsTeacher> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudentsTeacher> {
  late Future<QuerySnapshot> studentsFuture;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    studentsFuture = fetchStudents();
  }

  Future<QuerySnapshot> fetchStudents() async {
    return FirebaseFirestore.instance.collection('studentsdetails').get();
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
                'Student List',
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
            future: studentsFuture,
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Student Name')),
                        DataColumn(label: Text('Reg No')),
                        DataColumn(label: Text('Year')),
                        DataColumn(label: Text('Dept')),
                        // Add more columns if needed
                      ],
                      rows: documents.map((document) {
                        final data = document.data() as Map<String, dynamic>;
                        return DataRow(cells: [
                          DataCell(Text(data['student name'])),
                          DataCell(Text(data['registration number'])),
                          DataCell(Text(data['year'].toString())),
                          DataCell(Text(data['department'])),
                          // Add more cells if needed
                        ]);
                      }).toList(),
                    ),
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
