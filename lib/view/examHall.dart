import 'package:flutter/material.dart';

class SeatAllocation extends StatefulWidget {
  final List<Map<String, dynamic>> students1;
  final List<Map<String, dynamic>> students2;

  SeatAllocation({required this.students1, required this.students2});

  @override
  _SeatAllocationState createState() => _SeatAllocationState();
}

class _SeatAllocationState extends State<SeatAllocation> {
  // Sample list of seats in the exam hall
  final List<Seat> seats = List.generate(
    50,
    (index) => Seat(seatNumber: index + 1),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam Hall"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10, // Adjust the number of seats per row
          childAspectRatio: 1.2, // Aspect ratio of each seat
        ),
        itemCount: seats.length,
        itemBuilder: (BuildContext context, int index) {
          final seat = seats[index];
          // Check if the seat is allocated to a student
          final allocatedStudent = _getAllocatedStudent(seat.seatNumber);
          return GestureDetector(
            onTap: () {
              // Handle tap on seat (if needed)
              print("Seat ${seat.seatNumber} tapped");
            },
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: allocatedStudent != null ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  allocatedStudent ?? seat.seatNumber.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Function to get the student allocated to a seat
  String? _getAllocatedStudent(int seatNumber) {
    // Assuming students are allocated alternately to departments
    if (seatNumber % 2 == 0 && seatNumber ~/ 2 <= widget.students2.length) {
      return widget.students2[seatNumber ~/ 2]['name'];
    } else if ((seatNumber - 1) ~/ 2 < widget.students1.length) {
      return widget.students1[(seatNumber - 1) ~/ 2]['name'];
    }
    return null;
  }
}

class Seat {
  final int seatNumber;

  Seat({required this.seatNumber});
}

void main() {
  runApp(MaterialApp(
    home: SeatAllocation(
      // Sample data for demonstration
      students1: [
        {'name': 'Student 1'},
        {'name': 'Student 2'},
        {'name': 'Student 3'},
      ],
      students2: [
        {'name': 'Student 4'},
        {'name': 'Student 5'},
        {'name': 'Student 6'},
      ],
    ),
  ));
}
