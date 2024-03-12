class Student {
  final String name;
  final String department;

  Student({required this.name, required this.department});
}

class Classroom {
  final List<Student> students;
  final int maxCapacity;

  Classroom({required this.students, required this.maxCapacity});
}

List<Classroom> arrangeStudents(
    List<Student> csStudents, List<Student> microStudents) {
  List<Student> arrangedStudents = [];

  // Assuming both lists have equal length, otherwise adjust as needed
  int totalStudents = csStudents.length;

  for (int i = 0; i < totalStudents; i++) {
    // Add CS student
    arrangedStudents.add(csStudents[i]);

    // Add Micro student
    arrangedStudents.add(microStudents[i]);

    // Add another CS student
    arrangedStudents.add(csStudents[i]);
  }

  // Shuffle the arranged students to distribute them randomly among classrooms
  arrangedStudents.shuffle();

  // Divide students among classrooms
  int studentsPerClassroom = arrangedStudents.length ~/ 3;

  List<Classroom> classrooms = [];
  for (int i = 0; i < 3; i++) {
    int start = i * studentsPerClassroom;
    int end = (i + 1) * studentsPerClassroom;
    List<Student> studentsForClassroom = arrangedStudents.sublist(start, end);
    classrooms.add(Classroom(students: studentsForClassroom, maxCapacity: 30));
  }

  return classrooms;
}

void main() {
  // Sample data
  List<Student> csStudents = [
    Student(name: "CS Student 1", department: "CS"),
    Student(name: "CS Student 2", department: "CS"),
    Student(name: "CS Student 3", department: "CS"),
    // Add more CS students as needed
  ];

  List<Student> microStudents = [
    Student(name: "Micro Student 1", department: "Micro"),
    Student(name: "Micro Student 2", department: "Micro"),
    Student(name: "Micro Student 3", department: "Micro"),
    // Add more Micro students as needed
  ];

  // Arrange students into classrooms
  List<Classroom> classrooms = arrangeStudents(csStudents, microStudents);

  // Display classrooms and their students
  for (int i = 0; i < classrooms.length; i++) {
    print("Classroom ${i + 1}:");
    for (var student in classrooms[i].students) {
      print("  Name: ${student.name}, Department: ${student.department}");
    }
  }
}
