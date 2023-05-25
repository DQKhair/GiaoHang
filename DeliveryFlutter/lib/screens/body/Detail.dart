import 'package:delivery/Entities/DonHang.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  static DonHang? donHang;
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    if (donHang != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
            color: Colors.lightGreen,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mã đơn hàng: ${donHang!.maDonHang}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Trạng thái: ${donHang!.tenTrangThai}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 10, bottom: 5, right: 5),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Từ: ${donHang!.nguoiGui}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Địa chỉ: ${donHang!.tu}',
                  ),
                  Text(
                    'Số điện thoại: ${donHang!.sdtNguoiGui}',
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 20, bottom: 5, right: 5),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đến: ${donHang!.nguoiNhan}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Địa chỉ: ${donHang!.diaChiNguoiNhan}, ${donHang!.diaChiPhuong}, ${donHang!.diaChiQuan}, ${donHang!.diaChiThanhPho}',
                  ),
                  Text(
                    'Số điện thoại: ${donHang!.sdtNguoiNhan}',
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.lime,
            margin: const EdgeInsets.only(left: 25, bottom: 5, right: 5),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ghi Chú:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${donHang!.ghiChu}')
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return const Center(
        child: Text("Rỗng"),
      );
    }
  }
}
