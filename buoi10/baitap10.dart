import 'dart:io';

class Person {
  String id;
  String name;
  int age;
  String gender;

  Person(this.id, this.name, this.age, this.gender);
}

class Student extends Person {
  String grade;
  List<double> scores;

  Student(String id, String name, int age, String gender, this.grade)
    : scores = [],
      super(id, name, age, gender);

  void addScore(double score) {
    scores.add(score);
  }

  double get averageScore =>
      scores.isNotEmpty ? scores.reduce((a, b) => a + b) / scores.length : 0.0;

  void displayInfo() {
    print(
      "ID: $id, Tên: $name, Tuổi: $age, Giới tính: $gender, Lớp: $grade, Điểm trung bình: ${averageScore.toStringAsFixed(2)}",
    );
  }
}

class Teacher extends Person {
  String subject;
  double salary;

  Teacher(
    String id,
    String name,
    int age,
    String gender,
    this.subject,
    this.salary,
  ) : super(id, name, age, gender);

  void displayInfo() {
    print(
      "ID: $id, Tên: $name, Tuổi: $age, Giới tính: $gender, Môn học: $subject, Lương: \$${salary.toStringAsFixed(2)}",
    );
  }
}

class Classroom {
  String id;
  String name;
  List<Student> students;
  Teacher? teacher;

  Classroom(this.id, this.name) : students = [];

  void addStudent(Student student) {
    students.add(student);
    print("Thêm học sinh ${student.name} vào lớp $name thành công!");
  }

  void assignTeacher(Teacher teacher) {
    this.teacher = teacher;
    print("Gán giáo viên ${teacher.name} vào lớp $name thành công!");
  }

  void displayInfo() {
    print("\n=== Thông tin lớp học ===");
    print("ID lớp: $id, Tên lớp: $name");
    if (teacher != null) {
      print("Giáo viên phụ trách: ${teacher!.name}");
    } else {
      print("Chưa có giáo viên phụ trách.");
    }
    print("Danh sách học sinh:");
    for (var student in students) {
      student.displayInfo();
    }
    print("=========================\n");
  }
}

class SchoolManagement {
  List<Student> students = [];
  List<Teacher> teachers = [];
  List<Classroom> classrooms = [];

  void addStudent() {
    stdout.write("Nhập ID học sinh: ");
    String id = stdin.readLineSync() ?? "";
    stdout.write("Nhập tên học sinh: ");
    String name = stdin.readLineSync() ?? "";
    stdout.write("Nhập tuổi học sinh: ");
    int age = int.parse(stdin.readLineSync() ?? "0");
    stdout.write("Nhập giới tính học sinh: ");
    String gender = stdin.readLineSync() ?? "";
    stdout.write("Nhập lớp học: ");
    String grade = stdin.readLineSync() ?? "";

    var student = Student(id, name, age, gender, grade);
    students.add(student);
    print("Thêm học sinh thành công!");
  }

  void addTeacher() {
    stdout.write("Nhập ID giáo viên: ");
    String id = stdin.readLineSync() ?? "";
    stdout.write("Nhập tên giáo viên: ");
    String name = stdin.readLineSync() ?? "";
    stdout.write("Nhập tuổi giáo viên: ");
    int age = int.parse(stdin.readLineSync() ?? "0");
    stdout.write("Nhập giới tính giáo viên: ");
    String gender = stdin.readLineSync() ?? "";
    stdout.write("Nhập môn học: ");
    String subject = stdin.readLineSync() ?? "";
    stdout.write("Nhập lương: ");
    double salary = double.parse(stdin.readLineSync() ?? "0.0");

    var teacher = Teacher(id, name, age, gender, subject, salary);
    teachers.add(teacher);
    print("Thêm giáo viên thành công!");
  }

  void createClassroom() {
    stdout.write("Nhập ID lớp học: ");
    String id = stdin.readLineSync() ?? "";
    stdout.write("Nhập tên lớp học: ");
    String name = stdin.readLineSync() ?? "";

    var classroom = Classroom(id, name);
    classrooms.add(classroom);
    print("Tạo lớp học thành công!");
  }

  void assignStudentToClassroom() {
    stdout.write("Nhập ID lớp học: ");
    String classId = stdin.readLineSync() ?? "";
    var classroom = classrooms.firstWhere(
      (c) => c.id == classId,
      orElse: () => throw Exception("Không tìm thấy lớp học với ID: $classId"),
    );

    stdout.write("Nhập ID học sinh: ");
    String studentId = stdin.readLineSync() ?? "";
    var student = students.firstWhere(
      (s) => s.id == studentId,
      orElse: () => throw Exception("Không tìm thấy học sinh với ID: $studentId"),
    );

    classroom.addStudent(student);
  }

  void assignTeacherToClassroom() {
    stdout.write("Nhập ID lớp học: ");
    String classId = stdin.readLineSync() ?? "";
    var classroom = classrooms.firstWhere(
      (c) => c.id == classId,
      orElse: () => throw Exception("Không tìm thấy lớp học với ID: $classId"),
    );

    stdout.write("Nhập ID giáo viên: ");
    String teacherId = stdin.readLineSync() ?? "";
    var teacher = teachers.firstWhere(
      (t) => t.id == teacherId,
      orElse: () => throw Exception("Không tìm thấy giáo viên với ID: $teacherId"),
    );

    classroom.assignTeacher(teacher);
  }

  void displayClassrooms() {
    if (classrooms.isEmpty) {
      print("Danh sách lớp học trống.");
      return;
    }
    for (var classroom in classrooms) {
      classroom.displayInfo();
    }
  }
}

void main() {
  var schoolManagement = SchoolManagement();

  while (true) {
    print("\nCHƯƠNG TRÌNH QUẢN LÝ TRƯỜNG HỌC");
    print("--------------------------------");
    print("1. Thêm học sinh");
    print("2. Thêm giáo viên");
    print("3. Tạo lớp học");
    print("4. Gán học sinh vào lớp học");
    print("5. Gán giáo viên vào lớp học");
    print("6. Hiển thị thông tin lớp học");
    print("7. Thoát");
    print("--------------------------------");
    stdout.write("Chọn chức năng (1-7): ");

    String choice = stdin.readLineSync() ?? "";
    if (choice == "7") break;

    try {
      switch (choice) {
        case "1":
          schoolManagement.addStudent();
          break;
        case "2":
          schoolManagement.addTeacher();
          break;
        case "3":
          schoolManagement.createClassroom();
          break;
        case "4":
          schoolManagement.assignStudentToClassroom();
          break;
        case "5":
          schoolManagement.assignTeacherToClassroom();
          break;
        case "6":
          schoolManagement.displayClassrooms();
          break;
        default:
          print("Lựa chọn không hợp lệ. Vui lòng chọn từ 1-7.");
      }
    } catch (e) {
      print("Đã xảy ra lỗi: $e");
    }
  }
  print("Cảm ơn bạn đã sử dụng chương trình!");
}
