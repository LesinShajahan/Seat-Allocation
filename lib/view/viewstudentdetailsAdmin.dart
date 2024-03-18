import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seat_allocation/view/Adminhome.dart';

class ViewStudents extends StatefulWidget {
  ViewStudents({Key? key}) : super(key: key);

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
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
      body: FutureBuilder<QuerySnapshot>(
        future: studentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            // Grouping students by department
            Map<String, List<DocumentSnapshot>> studentsByDept = {};
            for (var document in documents) {
              final data = document.data() as Map<String, dynamic>;
              final dept = data['department'] as String;
              if (!studentsByDept.containsKey(dept)) {
                studentsByDept[dept] = [];
              }
              studentsByDept[dept]!.add(document);
            }
            return ListView.builder(
              itemCount: studentsByDept.length,
              itemBuilder: (context, index) {
                final dept = studentsByDept.keys.elementAt(index);
                final studentsInDept = studentsByDept[dept]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '$dept Department',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('S.No')),
                          DataColumn(label: Text('Student Name')),
                          DataColumn(label: Text('Reg No')),
                          DataColumn(label: Text('Year')),
                          DataColumn(label: Text('Dept')),
                          // Add more columns if needed
                        ],
                        rows: studentsInDept.asMap().entries.map((entry) {
                          final index = entry.key + 1;
                          final document = entry.value;
                          final data = document.data() as Map<String, dynamic>;
                          return DataRow(cells: [
                            DataCell(Text(index.toString())),
                            DataCell(Text(data['student name'])),
                            DataCell(Text(data['registration number'])),
                            DataCell(Text(data['year'].toString())),
                            DataCell(Text(data['department'])),
                            // Add more cells if needed
                          ]);
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
