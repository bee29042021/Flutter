import 'dart:io';
import 'dart:math';

class Calculator {
  double add(double a, double b) => a + b;
  double subtract(double a, double b) => a - b;
  double multiply(double a, double b) => a * b;
  double divide(double a, double b) {
    if (b == 0) {
      print("Lỗi: Không thể chia cho 0.");
      return 0.0;
    }
    return a / b;
  }
}

void main() {
  var calculator = Calculator();
  print("Chương trình máy tính đơn giản");
  while (true) {
    print("Chọn phép toán:");
    print("1. Cộng");
    print("2. Trừ");
    print("3. Nhân");
    print("4. Chia");
    print("5. Tính mũ");
    print("6. Tính căn bậc 2");
    print("7. Thoát");

    String choice = stdin.readLineSync() ?? "";
    if (choice == "7")
      break;
    else if (choice == "6") {
      stdout.write("Nhập số cần tính căn bậc 2: ");
      double num = double.parse(stdin.readLineSync() ?? "0.0");
      print("Kết quả: ${sqrt(num)}");
      continue;
    } else if (choice == "5") {
      stdout.write("Nhập cơ số: ");
      double numcs = double.parse(stdin.readLineSync() ?? "0.0");
      stdout.write("Nhập số mũ : ");
      double numsm = double.parse(stdin.readLineSync() ?? "0.0");
      print("Kết quả: ${pow(numcs, numsm)}");

      continue;
    } else {
      stdout.write("Nhập số thứ nhất: ");
      double num1 = double.parse(stdin.readLineSync() ?? "0.0");
      stdout.write("Nhập số thứ hai: ");
      double num2 = double.parse(stdin.readLineSync() ?? "0.0");

      switch (choice) {
        case "1":
          print("Kết quả: ${calculator.add(num1, num2)}");
          break;
        case "2":
          print("Kết quả: ${calculator.subtract(num1, num2)}");
          break;
        case "3":
          print("Kết quả: ${calculator.multiply(num1, num2)}");
          break;
        case "4":
          print("Kết quả: ${calculator.divide(num1, num2)}");
          break;

        default:
          print("Lựa chọn không hợp lệ.");
      }
    }
  }
}
