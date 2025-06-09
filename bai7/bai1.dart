import 'dart:io';

void main() {
  List<String> sinhVien = [];
  List<double> diemTrungBinhList = [];

  while (true) {
    stdout.write("Mời nhập tên sinh viên: ");
    var tenSV = stdin.readLineSync();

    stdout.write("Mời nhập điểm toán: ");
    var diemToan = double.parse(stdin.readLineSync()!);

    stdout.write("Mời nhập điểm lý: ");
    var diemLy = double.parse(stdin.readLineSync()!);

    stdout.write("Mời nhập điểm hoá: ");
    var diemHoa = double.parse(stdin.readLineSync()!);

    double dtb = diemTrungBinh(diemToan, diemLy, diemHoa);
    diemTrungBinhList.add(dtb);

    String hocLuc = hocLucSinhVien(dtb);

    sinhVien.add(
      "Tên sinh viên: $tenSV, Điểm toán: $diemToan, Điểm lý: $diemLy, Điểm hoá: $diemHoa, Điểm trung bình: ${dtb.toStringAsFixed(2)}, Học lực: $hocLuc",
    );

    stdout.write("Bạn có muốn nhập sinh viên không? (Y/N): ");
    var nhap = stdin.readLineSync();

    if (nhap?.toUpperCase() != "Y") {
      break;
    }
  }

  print("\nDanh sách sinh viên: ");
  for (var sv in sinhVien) {
    print(sv);
  }

  if (diemTrungBinhList.isNotEmpty) {
    double maxDTB = diemTrungBinhList[0];
    int indexMax = 0;
    for (int i = 1; i < diemTrungBinhList.length; i++) {
      if (diemTrungBinhList[i] > maxDTB) {
        maxDTB = diemTrungBinhList[i];
        indexMax = i;
      }
    }
    print("\nSinh viên có điểm trung bình cao nhất:");
    print(sinhVien[indexMax]);
  }
}

double diemTrungBinh(double diemToan, double diemLy, double diemHoa) {
  return (diemToan + diemLy + diemHoa) / 3;
}

String hocLucSinhVien(double diemTrungBinh) {
  if (diemTrungBinh > 9) {
    return "Xuất sắc";
  } else if (diemTrungBinh >= 7 && diemTrungBinh <= 9) {
    return "Giỏi";
  } else if (diemTrungBinh >= 5 && diemTrungBinh < 7) {
    return "Khá";
  } else {
    return "Kém";
  }
}