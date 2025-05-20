import 'dart:io';

class BankAccount {
  String accountNumber;
  String ownerName;
  double balance;

  BankAccount(this.accountNumber, this.ownerName, this.balance);

  void deposit(double amount) {
    if (amount <= 0) {
      print("Số tiền gửi phải lớn hơn 0.");
      return;
    }
    balance += amount;
    print(
      "Đã gửi \$${amount.toStringAsFixed(2)} vào tài khoản. Số dư hiện tại: \$${balance.toStringAsFixed(2)}",
    );
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      print("Số tiền rút phải lớn hơn 0.");
      return;
    }
    if (amount > balance) {
      print("Số dư không đủ để rút \$${amount.toStringAsFixed(2)}.");
      return;
    }
    balance -= amount;
    print(
      "Đã rút \$${amount.toStringAsFixed(2)} từ tài khoản. Số dư hiện tại: \$${balance.toStringAsFixed(2)}",
    );
  }

  void displayBalance() {
    print("Số dư tài khoản: \$${balance.toStringAsFixed(2)}");
  }
}

class BankAccountManagement {
  List<BankAccount> accounts = [];

  void addAccount() {
    stdout.write("Nhập số tài khoản: ");
    String accountNumber = stdin.readLineSync() ?? "";
    stdout.write("Nhập tên chủ tài khoản: ");
    String ownerName = stdin.readLineSync() ?? "";
    stdout.write("Nhập số dư ban đầu: ");
    double balance = double.parse(stdin.readLineSync() ?? "0.0");

    var account = BankAccount(accountNumber, ownerName, balance);
    accounts.add(account);
    print("Đã thêm tài khoản thành công!");
  }

  BankAccount? findAccountByNumber(String accountNumber) {
    for (var account in accounts) {
      if (account.accountNumber == accountNumber) {
        return account;
      }
    }
    print("Không tìm thấy tài khoản với số tài khoản: $accountNumber");
    return null;
  }
}

void main() {
  var management = BankAccountManagement();

  while (true) {
    print("\nChương trình quản lý tài khoản ngân hàng");
    print("1. Thêm mới tài khoản");
    print("2. Gửi tiền");
    print("3. Rút tiền");
    print("4. Hiển thị số dư");
    print("5. Thoát");
    stdout.write("Chọn chức năng: ");
    String choice = stdin.readLineSync() ?? "";

    switch (choice) {
      case '1':
        management.addAccount();
        break;
      case '2':
        {
          stdout.write("Nhập số tài khoản để gửi tiền: ");
          String accountNumber = stdin.readLineSync() ?? "";
          var account = management.findAccountByNumber(accountNumber);
          if (account != null) {
            stdout.write("Nhập số tiền gửi: ");
            double amount = double.parse(stdin.readLineSync() ?? "0");
            account.deposit(amount);
          }
          break;
        }
      case '3':
        {
          stdout.write("Nhập số tài khoản để rút tiền: ");
          String accountNumber = stdin.readLineSync() ?? "";
          var account = management.findAccountByNumber(accountNumber);
          if (account != null) {
            stdout.write("Nhập số tiền rút: ");
            double amount = double.parse(stdin.readLineSync() ?? "0");
            account.withdraw(amount);
          }
          break;
        }
      case '4':
        {
          stdout.write("Nhập số tài khoản để hiển thị số dư: ");
          String accountNumber = stdin.readLineSync() ?? "";
          var account = management.findAccountByNumber(accountNumber);
          if (account != null) {
            account.displayBalance();
          }
          break;
        }
      case '5':
        print("Kết thúc chương trình.");
        return;
      default:
        print("Lựa chọn không hợp lệ. Vui lòng thử lại.");
    }
  }
}
