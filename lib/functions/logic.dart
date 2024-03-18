import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String registrationNumber;
  final String department;

  Student({required this.registrationNumber, required this.department});
}

class ExamHall {
  final int hallId;
  final int capacity;

  ExamHall({required this.hallId, required this.capacity});
}

Future<Map<int, List<Student>>> arrangeStudentsInExamHalls() async {
  // Retrieve student details from Firestore
  final studentsSnapshot =
      await FirebaseFirestore.instance.collection("studentsdetails").get();

  List<Student> students = studentsSnapshot.docs.map((doc) {
    return Student(
      registrationNumber: doc.data()["registration_number"],
      department: doc.data()["department"],
    );
  }).toList();

  // Retrieve exam hall details from Firestore
  final examHallsSnapshot =
      await FirebaseFirestore.instance.collection("examhall").get();

  List<ExamHall> examHalls = examHallsSnapshot.docs.map((doc) {
    return ExamHall(
      hallId: doc.data()["hall_id"],
      capacity: doc.data()["capacity"],
    );
  }).toList();

  // Sorting students based on department
  students.sort((a, b) => a.department.compareTo(b.department));

  Map<int, List<Student>> seatAllocations = {};

  int studentIndex = 0;
  for (var hall in examHalls) {
    // Allocate students to exam hall
    List<Student> allocatedStudents = [];
    int remainingSeats = hall.capacity;
    String currentDepartment = ""; // Track current department

    while (remainingSeats > 0 && studentIndex < students.length) {
      // Pick the next student from a different department
      Student nextStudent = students[studentIndex];
      if (nextStudent.department != currentDepartment) {
        allocatedStudents.add(nextStudent);
        studentIndex++;
        remainingSeats--;
        currentDepartment = nextStudent.department;
      } else {
        // Skip the current student and search for the next student from a different department
        studentIndex++;
      }
    }

    // Store allocated students in the map
    seatAllocations[hall.hallId] = allocatedStudents;
  }

  return seatAllocations;
}

void main() async {
  Map<int, List<Student>> seatAllocations = await arrangeStudentsInExamHalls();
  print("Seat allocations:");
  seatAllocations.forEach((hallId, students) {
    print("Hall ID: $hallId");
    students.forEach((student) {
      print(
          "  Registration Number: ${student.registrationNumber}, Department: ${student.department}");
    });
  });
}
