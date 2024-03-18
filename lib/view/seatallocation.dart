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
  int? hallCapacity;
  String? selectedDepartment1;
  String? selectedDepartment2;
  List<Map<String, dynamic>> students1 = [];
  List<Map<String, dynamic>> students2 = [];

  Future<List<String>> fetchDepartments() async {
    QuerySnapshot departmentSnapshot =
        await FirebaseFirestore.instance.collection('departmentdetails').get();
    List<String> departments =
        departmentSnapshot.docs.map((doc) => doc.id).toList();
    return departments;
  }

  Future<void> fetchHallDetails(String hallId) async {
    try {
      DocumentSnapshot hallSnapshot = await FirebaseFirestore.instance
          .collection('examhall')
          .doc(hallId)
          .get();

      if (hallSnapshot.exists) {
        Map<String, dynamic> hallData =
            hallSnapshot.data() as Map<String, dynamic>;

        setState(() {
          hallCapacity = hallData['capacity'];
          hallName = hallData['name'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hall with ID $hallId does not exist!'),
          ),
        );
      }
    } catch (e) {
      print('Error fetching hall details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching hall details: $e'),
        ),
      );
    }
  }

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

      students1.shuffle();
    }

    if (selectedDepartment2 != null) {
      QuerySnapshot studentsSnapshot = await FirebaseFirestore.instance
          .collection('studentsdetails')
          .where('department', isEqualTo: selectedDepartment2)
          .get();

      students2.addAll(studentsSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>));

      students2.shuffle();
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

  List<String> allocateSeats() {
    List<String> allocatedSeats = [];

    int row = 1;
    int seat = 1;

    // Iterate through students1 and students2 lists
    for (int i = 0; i < students1.length || i < students2.length; i++) {
      // If students1 list has a student at index i
      if (i < students1.length) {
        // Assign seat to student from students1
        String allocatedSeat =
            'Row $row | Seat $seat | ${students1[i]['student name']} | ${students1[i]['department']}';
        allocatedSeats.add(allocatedSeat);

        // Increment seat index
        seat++;

        // If the seat exceeds the hall capacity per row, move to the next row
        if (seat > hallCapacity!) {
          row++;
          seat = 1;
        }
      }

      // If students2 list has a student at index i
      if (i < students2.length) {
        // Assign seat to student from students2
        String allocatedSeat =
            'Row $row | Seat $seat | ${students2[i]['student name']} | ${students2[i]['department']}';
        allocatedSeats.add(allocatedSeat);

        // Increment seat index
        seat++;

        // If the seat exceeds the hall capacity per row, move to the next row
        if (seat > hallCapacity!) {
          row++;
          seat = 1;
        }
      }
    }

    return allocatedSeats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SEAT ALLOCATION",
          style: TextStyle(color: Colors.white),
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
                // Allocate seats and retrieve the allocated seat data
                List<String> allocatedSeats = allocateSeats();

                // Show the allocated seats in a dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Allocated Seats"),
                      content: Container(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: allocatedSeats.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(allocatedSeats[index]),
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
