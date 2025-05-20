import 'dart:io';

class Student {
  String id;
  String name;
  int age;
  double grade;

  Student(this.id, this.name, this.age, this.grade);

  void inputInfo() {
    stdout.write("Nhập ID sinh viên: ");
    id = stdin.readLineSync() ?? "";
    stdout.write("Nhập tên sinh viên: ");
    name = stdin.readLineSync() ?? "";
    stdout.write("Nhập tuổi sinh viên: ");
    age = int.parse(stdin.readLineSync() ?? "0");
    stdout.write("Nhập điểm sinh viên: ");
    grade = double.parse(stdin.readLineSync() ?? "0.0");
  }

  void displayInfo() {
    print("ID: $id, Tên: $name, Tuổi: $age, Điểm: $grade");
  }
}

class StudentManagement {
  List<Student> students = [];

  void addStudent() {
    var student = Student("", "", 0, 0.0);
    student.inputInfo();
    students.add(student);
    print("Thêm sinh viên thành công!");
  }

  void displayStudents() {
    if (students.isEmpty) {
      print("Danh sách sinh viên trống.");
      return;
    }
    for (var student in students) {
      student.displayInfo();
    }
  }

  void searchStudentById(String studentId) {
    for (var student in students) {
      if (student.id == studentId) {
        student.displayInfo();
        return;
      }
    }
    print("Không tìm thấy sinh viên với ID: $studentId");
  }
}

void main() {
  var management = StudentManagement();
  while (true) {
    print("\nChương trình quản lý sinh viên");
    print("1. Thêm mới sinh viên");
    print("2. Hiển thị danh sách sinh viên");
    print("3. Tìm kiếm sinh viên theo ID");
    print("4. Thoát");
    stdout.write("Chọn chức năng: ");
    String choice = stdin.readLineSync() ?? "";

    switch (choice) {
      case '1':
        management.addStudent();
        break;
      case '2':
        management.displayStudents();
        break;
      case '3':
        stdout.write("Nhập ID sinh viên cần tìm: ");
        String studentId = stdin.readLineSync() ?? "";
        management.searchStudentById(studentId);
        break;
      case '4':
        print("Kết thúc chương trình.");
        return;
      default:
        print("Lựa chọn không hợp lệ. Vui lòng thử lại.");
    }
  }
}
