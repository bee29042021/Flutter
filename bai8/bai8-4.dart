import 'dart:io';

class Product {
  String id;
  String name;
  double price;

  Product(this.id, this.name, this.price);

  void inputInfo() {
    stdout.write("Nhập ID sản phẩm: ");
    id = stdin.readLineSync() ?? "";
    stdout.write("Nhập tên sản phẩm: ");
    name = stdin.readLineSync() ?? "";
    stdout.write("Nhập giá sản phẩm: ");
    price = double.parse(stdin.readLineSync() ?? "0.0");
  }

  void displayInfo() {
    print("ID: $id, Tên SP: $name, Giá: \$${price.toStringAsFixed(2)}");
  }
}

class ProductManagement {
  List<Product> products = [];

  void addProduct() {
    var product = Product("", "", 0.0);
    product.inputInfo();
    products.add(product);
    print("Thêm sản phẩm thành công!");
  }

  void displayProducts() {
    if (products.isEmpty) {
      print("Danh sách sản phẩm trống.");
      return;
    }
    for (var product in products) {
      product.displayInfo();
    }
  }

  Product? findProductById(String productId) {
    try {
      return products.firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }
}

class OrderItem {
  String productId;
  int quantity;
  double unitPrice;
  String productName;

  OrderItem(this.productId, this.quantity, this.unitPrice, this.productName);

  double get total => quantity * unitPrice;

  void displayInfo() {
    print("Sản phẩm: $productName (ID: $productId)");
    print("Số lượng: $quantity");
    print("Đơn giá: \${unitPrice.toStringAsFixed(2)}");
    print("Thành tiền: \${total.toStringAsFixed(2)}");
  }
}

class Order {
  String id;
  List<OrderItem> items = [];
  DateTime orderDate;

  Order(this.id) : orderDate = DateTime.now();

  void addItem(Product product, int quantity) {
    items.add(OrderItem(product.id, quantity, product.price, product.name));
  }

  double get totalAmount => items.fold(0, (sum, item) => sum + item.total);

  void inputInfo(ProductManagement productMgmt) {
    stdout.write("Nhập ID đơn hàng: ");
    id = stdin.readLineSync() ?? "";

    while (true) {
      stdout.write("\nNhập ID sản phẩm (nhập 'X' để kết thúc): ");
      String productId = stdin.readLineSync() ?? "";
      if (productId.toLowerCase() == 'X') break;

      Product? product = productMgmt.findProductById(productId);
      if (product == null) {
        print("Không tìm thấy sản phẩm với ID: $productId");
        continue;
      }

      stdout.write("Nhập số lượng: ");
      int quantity;
      try {
        quantity = int.parse(stdin.readLineSync() ?? "0");
        if (quantity <= 0) throw FormatException();
      } catch (e) {
        print("Số lượng không hợp lệ. Vui lòng nhập lại.");
        continue;
      }

      addItem(product, quantity);
      print("Đã thêm sản phẩm vào đơn hàng.");
    }
  }

  void displayInfo() {
    print("\n=== Chi tiết đơn hàng ===");
    print("ID đơn hàng: $id");
    print("Ngày đặt: ${orderDate.toString().split('.')[0]}");
    print("\nDanh sách sản phẩm:");
    for (var item in items) {
      print("------------------------");
      item.displayInfo();
    }
    print("------------------------");
    print("Tổng giá trị đơn hàng: \$${totalAmount.toStringAsFixed(2)}");
    print("======================\n");
  }
}

class OrderManagement {
  List<Order> orders = [];

  void addOrder(ProductManagement productMgmt) {
    var order = Order("");
    order.inputInfo(productMgmt);
    if (order.items.isNotEmpty) {
      orders.add(order);
      print("Thêm đơn hàng thành công!");
    } else {
      print("Đơn hàng trống. Hủy thêm đơn hàng.");
    }
  }

  void displayOrders() {
    if (orders.isEmpty) {
      print("Danh sách đơn hàng trống.");
      return;
    }
    for (var order in orders) {
      order.displayInfo();
    }
  }

  void searchOrderById(String orderId) {
    var order = orders.firstWhere(
      (order) => order.id == orderId,
      orElse: () => Order(""),
    );
    if (order.id.isEmpty) {
      print("Không tìm thấy đơn hàng với ID: $orderId");
    } else {
      order.displayInfo();
    }
  }
}

void main() {
  var productManagement = ProductManagement();
  var orderManagement = OrderManagement();

  while (true) {
    print("\nCHƯƠNG TRÌNH QUẢN LÝ BÁN HÀNG");
    print("--------------------------------");
    print("1. Thêm mới sản phẩm");
    print("2. Hiển thị danh sách sản phẩm");
    print("3. Tìm kiếm sản phẩm theo ID");
    print("4. Tạo đơn hàng mới");
    print("5. Hiển thị danh sách đơn hàng");
    print("6. Tìm kiếm đơn hàng theo ID");
    print("7. Thoát");
    print("--------------------------------");
    stdout.write("Chọn chức năng (1-7): ");

    String choice = stdin.readLineSync() ?? "";
    if (choice == "7") break;

    try {
      switch (choice) {
        case "1":
          productManagement.addProduct();
          break;
        case "2":
          productManagement.displayProducts();
          break;
        case "3":
          stdout.write("Nhập ID sản phẩm cần tìm: ");
          String id = stdin.readLineSync() ?? "";
          var product = productManagement.findProductById(id);
          if (product != null) {
            product.displayInfo();
          } else {
            print("Không tìm thấy sản phẩm với ID: $id");
          }
          break;
        case "4":
          orderManagement.addOrder(productManagement);
          break;
        case "5":
          orderManagement.displayOrders();
          break;
        case "6":
          stdout.write("Nhập ID đơn hàng cần tìm: ");
          String orderId = stdin.readLineSync() ?? "";
          orderManagement.searchOrderById(orderId);
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
