import 'dart:io';

class Product {
  String name;
  double price;
  int quantity;

  Product(this.name, this.price, this.quantity);
}

void main() {
  List<Product> products = [];

  while (true) {
    print("Chọn chức năng:");
    print("1. Thêm sản phẩm");
    print("2. Hiển thị danh sách sản phẩm");
    print("3. Tìm kiếm sản phẩm");
    print("4. Bán sản phẩm");
    print("5. Thoát");

    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addProduct(products);
        break;
      case '2':
        displayProducts(products);
        break;
      case '3':
        searchProduct(products);
        break;
      case '4':
        sellProduct(products);
        break;
      case '5':
        print("Thoát chương trình.");
        return;
      default:
        print("Lựa chọn không hợp lệ. Vui lòng thử lại.");
    }
  }
}

void addProduct(List<Product> products) {
  stdout.write("Nhập tên sản phẩm: ");
  var name = stdin.readLineSync()!;

  stdout.write("Nhập giá tiền: ");
  var price = double.parse(stdin.readLineSync()!);

  stdout.write("Nhập số lượng trong kho: ");
  var quantity = int.parse(stdin.readLineSync()!);

  products.add(Product(name, price, quantity));
  print("Sản phẩm đã được thêm vào danh sách.");
}

void displayProducts(List<Product> products) {
  if (products.isEmpty) {
    print("Danh sách sản phẩm trống.");
    return;
  }

  print("\nDanh sách sản phẩm:");
  for (var product in products) {
    print(
      "Tên: ${product.name}, Giá: ${product.price}, Số lượng: ${product.quantity}",
    );
  }
}

void searchProduct(List<Product> products) {
  stdout.write("Nhập tên sản phẩm cần tìm: ");
  var name = stdin.readLineSync()!;

  var foundProducts =
      products
          .where(
            (product) =>
                product.name.toLowerCase().contains(name.toLowerCase()),
          )
          .toList();

  if (foundProducts.isEmpty) {
    print("Không tìm thấy sản phẩm.");
  } else {
    print("Kết quả tìm kiếm:");
    for (var product in foundProducts) {
      print(
        "Tên: ${product.name}, Giá: ${product.price}, Số lượng: ${product.quantity}",
      );
    }
  }
}

void sellProduct(List<Product> products) {
  stdout.write("Nhập tên sản phẩm cần bán: ");
  var name = stdin.readLineSync()!;

  var productIndex = products.indexWhere(
    (p) => p.name.toLowerCase() == name.toLowerCase(),
  );

  if (productIndex == -1) {
    print("Sản phẩm không tồn tại.");
    return;
  }
  var product = products[productIndex];

  stdout.write("Nhập số lượng cần bán: ");
  var quantityToSell = int.parse(stdin.readLineSync()!);

  if (quantityToSell > product.quantity) {
    print("Số lượng hàng không đủ để bán.");
  } else {
    product.quantity -= quantityToSell;
    print(
      "Đã bán $quantityToSell sản phẩm ${product.name}. Số lượng còn lại: ${product.quantity}.",
    );
  }
}
