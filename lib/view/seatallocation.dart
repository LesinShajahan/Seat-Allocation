import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seat Allocation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SeatAllocationPage(),
    );
  }
}

class SeatAllocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Allocation Demo'),
      ),
      body: SeatAllocation(),
    );
  }
}

class SeatAllocation extends StatefulWidget {
  SeatAllocation({Key? key}) : super(key: key);

  @override
  State<SeatAllocation> createState() => _SeatAllocationState();
}

class _SeatAllocationState extends State<SeatAllocation> {
  Future<List<String>> fetchDepartments() async {
    QuerySnapshot departmentSnapshot =
        await FirebaseFirestore.instance.collection('departmentdetails').get();
    List<String> departments =
        departmentSnapshot.docs.map((doc) => doc.id).toList();
    return departments;
  }

  TextEditingController hallIdController = TextEditingController();
  String? hallName;
  int? hallcapacity;
  String? selectedDepartment1;
  String? selectedDepartment2;

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

  List<Map<String, dynamic>> students1 = [];
  List<Map<String, dynamic>> students2 = [];

  Future<void> fetchStudentsFromDepartment() async {
    students1.clear();
    students2.clear();

    if (selectedDepartment1 != null) {
      QuerySnapshot studentsSnapshot = await FirebaseFirestore.instance
          .collection('studentsdetails')
          .where('department', isEqualTo: selectedDepartment1)
          .get();

      students1.addAll(studentsSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>));

      // Shuffle the list of students1
      students1.shuffle();

      for (Map<String, dynamic> student in students1) {
        print('Student Details (Department 1): $student');
      }
    }

    if (selectedDepartment2 != null) {
      QuerySnapshot studentsSnapshot = await FirebaseFirestore.instance
          .collection('studentsdetails')
          .where('department', isEqualTo: selectedDepartment2)
          .get();

      students2.addAll(studentsSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>));

      // Shuffle the list of students2
      students2.shuffle();

      for (Map<String, dynamic> student in students2) {
        print('Student Details (Department 2): $student');
      }
    }
  }

  Future<void> showDepartmentDialog(Function(List<String?>) callback) async {
    List<String> departments = await fetchDepartments();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Departments'),
          content: SingleChildScrollView(
            child: ListBody(
              children: departments
                  .map(
                    (department) => CheckboxListTile(
                      title: Text(department),
                      value: selectedDepartment1 == department ||
                          selectedDepartment2 == department,
                      onChanged: (bool? value) {
                        if (value == true) {
                          if (selectedDepartment1 == null) {
                            selectedDepartment1 = department;
                          } else if (selectedDepartment2 == null) {
                            selectedDepartment2 = department;
                          }
                        } else {
                          if (selectedDepartment1 == department) {
                            selectedDepartment1 = null;
                          } else if (selectedDepartment2 == department) {
                            selectedDepartment2 = null;
                          }
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                List<String?> selectedDepartments = [
                  selectedDepartment1,
                  selectedDepartment2
                ];
                callback(selectedDepartments);

                await fetchStudentsFromDepartment();

                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void clearSelectedDepartments() {
    setState(() {
      selectedDepartment1 = null;
      selectedDepartment2 = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seat Allocation"),
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
                  fetchHallDetails(hallId).then((_) {
                    showDepartmentDialog((selectedDepartments) {
                      setState(() {
                        if (selectedDepartments.length == 2) {
                          selectedDepartment1 = selectedDepartments[0];
                          selectedDepartment2 = selectedDepartments[1];
                        } else if (selectedDepartments.length == 1) {
                          selectedDepartment1 = selectedDepartments[0];
                          selectedDepartment2 = null;
                        } else {
                          selectedDepartment1 = null;
                          selectedDepartment2 = null;
                        }
                      });
                    });
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a Hall ID!'),
                    ),
                  );
                }
              },
              child: Text("Fetch Details"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: clearSelectedDepartments,
              child: Text("Clear Selected Departments"),
            ),
            SizedBox(height: 20),
            if (hallName != null) Text('Hall Name: $hallName'),
            SizedBox(height: 20),
            if (selectedDepartment1 != null)
              Text('Selected Department 1: $selectedDepartment1'),
            if (selectedDepartment2 != null)
              Text('Selected Department 2: $selectedDepartment2'),
            TextButton(
              onPressed: () {
                // Initialize variables for row and seat indices
                int row = 1;
                int seat = 1;

                List<String> tableData = [];

                // Add table header
                tableData.add('Row | Seat | Student Name | Department');

                // Loop through all students from department 1
                for (Map<String, dynamic> student in students1) {
                  // Assign seat to student
                  String allocatedSeat =
                      'Row $row | Seat $seat | ${student['name']} | ${student['department']}';
                  tableData.add(allocatedSeat);

                  // Increment seat index
                  seat++;

                  // If seat exceeds capacity per row, move to next row
                  if (seat > 10) {
                    row++;
                    seat = 1;
                  }
                }

                // Loop through all students from department 2
                for (Map<String, dynamic> student in students2) {
                  // Assign seat to student
                  String allocatedSeat =
                      'Row $row | Seat $seat | ${student['name']} | ${student['department']}';
                  tableData.add(allocatedSeat);

                  // Increment seat index
                  seat++;

                  // If seat exceeds capacity per row, move to next row
                  if (seat > 10) {
                    row++;
                    seat = 1;
                  }
                }

                // Print table footer
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Allocated Seats"),
                      content: Container(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: tableData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(tableData[index]),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text("Allocate seats for students"),
            )
          ],
        ),
      ),
    );
  }
}
