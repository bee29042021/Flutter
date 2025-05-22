import 'dart:io';

// Danh sách giỏ hàng sử dụng List<Map>
List<Map<String, dynamic>> cart = [];

// 1. Thêm sản phẩm vào giỏ hàng
void addProduct() {
  Map<String, dynamic> product = {};

  stdout.write("Nhập tên sản phẩm: ");
  product['name'] = stdin.readLineSync() ?? "";

  stdout.write("Nhập số lượng: ");
  try {
    product['quantity'] = int.parse(stdin.readLineSync() ?? "0");
  } catch (e) {
    print("Số lượng không hợp lệ. Đặt mặc định là 0.");
    product['quantity'] = 0;
  }

  stdout.write("Nhập giá tiền: ");
  try {
    product['price'] = double.parse(stdin.readLineSync() ?? "0");
  } catch (e) {
    print("Giá tiền không hợp lệ. Đặt mặc định là 0.");
    product['price'] = 0.0;
  }

  cart.add(product);
  print("Đã thêm sản phẩm vào giỏ hàng!");
}

// 2. Sửa sản phẩm trong giỏ hàng
void editProduct() {
  if (cart.isEmpty) {
    print("Giỏ hàng trống!");
    return;
  }

  displayCart();
  stdout.write("Nhập số thứ tự sản phẩm cần sửa (1-${cart.length}): ");
  try {
    int index = int.parse(stdin.readLineSync() ?? "0") - 1;
    if (index < 0 || index >= cart.length) {
      print("Số thứ tự không hợp lệ!");
      return;
    }

    print("Sửa thông tin sản phẩm (Enter để giữ nguyên):");

    stdout.write("Tên sản phẩm (${cart[index]['name']}): ");
    String newName = stdin.readLineSync() ?? "";
    if (newName.isNotEmpty) {
      cart[index]['name'] = newName;
    }

    stdout.write("Số lượng (${cart[index]['quantity']}): ");
    String newQuantity = stdin.readLineSync() ?? "";
    if (newQuantity.isNotEmpty) {
      cart[index]['quantity'] = int.parse(newQuantity);
    }

    stdout.write("Giá tiền (${cart[index]['price']}): ");
    String newPrice = stdin.readLineSync() ?? "";
    if (newPrice.isNotEmpty) {
      cart[index]['price'] = double.parse(newPrice);
    }

    print("Đã cập nhật sản phẩm!");
  } catch (e) {
    print("Đã xảy ra lỗi: $e");
  }
}

// Xóa sản phẩm khỏi giỏ hàng
void removeProduct() {
  if (cart.isEmpty) {
    print("Giỏ hàng trống!");
    return;
  }

  displayCart();
  stdout.write("Nhập số thứ tự sản phẩm cần xóa (1-${cart.length}): ");
  try {
    int index = int.parse(stdin.readLineSync() ?? "0") - 1;
    if (index < 0 || index >= cart.length) {
      print("Số thứ tự không hợp lệ!");
      return;
    }

    var removedProduct = cart.removeAt(index);
    print("Đã xóa sản phẩm: ${removedProduct['name']}");
  } catch (e) {
    print("Đã xảy ra lỗi: $e");
  }
}

// 3. Hiển thị giỏ hàng
void displayCart() {
  if (cart.isEmpty) {
    print("Giỏ hàng trống!");
    return;
  }

  print("\n=== GIỎ HÀNG ===");
  print("STT  |  Tên sản phẩm  |  Số lượng  |  Giá tiền  |  Thành tiền");
  print("--------------------------------------------------------");

  for (int i = 0; i < cart.length; i++) {
    var product = cart[i];
    double subtotal = product['quantity'] * product['price'];
    print(
      "${i + 1}    |  ${product['name']}  |  ${product['quantity']}  |  ${product['price']}  |  $subtotal",
    );
  }

  print("--------------------------------------------------------");
  print("Tổng tiền: ${calculateTotal()}\n");
}

// 4. Tính tổng tiền hóa đơn
double calculateTotal() {
  double total = 0;
  for (var product in cart) {
    total += product['quantity'] * product['price'];
  }
  return total;
}

// Menu chính
void showMenu() {
  print("\nCHƯƠNG TRÌNH QUẢN LÝ HÓA ĐƠN BÁN HÀNG");
  print("1. Thêm sản phẩm vào giỏ hàng");
  print("2. Sửa sản phẩm trong giỏ hàng");
  print("3. Xóa sản phẩm khỏi giỏ hàng");
  print("4. Hiển thị giỏ hàng");
  print("5. Tính tổng tiền hóa đơn");
  print("6. Thoát");
  stdout.write("Chọn chức năng (1-6): ");
}

void main() {
  while (true) {
    showMenu();
    String choice = stdin.readLineSync() ?? "";

    switch (choice) {
      case "1":
        addProduct();
        break;
      case "2":
        editProduct();
        break;
      case "3":
        removeProduct();
        break;
      case "4":
        displayCart();
        break;
      case "5":
        print("Tổng tiền hóa đơn: ${calculateTotal()}");
        break;
      case "6":
        print("Cảm ơn bạn đã sử dụng chương trình!");
        return;
      default:
        print("Lựa chọn không hợp lệ!");
    }
  }
}
