import 'package:delivery/Entities/ApiHelper.dart';
import 'package:delivery/Entities/User.dart';
import 'package:delivery/screens/body/Detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:delivery/Entities/DonHang.dart';
import 'package:delivery/screens/BodyScreen.dart';

class Home extends StatelessWidget {
  final PageController _pageController;
  const Home(this._pageController, {super.key});
  Future<List<DonHang>> _layDonHang() async {
    UserSession u = UserSession.fromJson(await SessionManager().get("user"));
    final response = await http.post(
      Uri.parse('${ApiHelper.ip}/nvgh/laydonhang/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, int>{
        'id': u.maNhanVien,
      }),
    );

    if (response.statusCode == 200) {
      List<DonHang> listDonHang = List.empty(growable: true);
      for (var donHang in jsonDecode(response.body)) {
        listDonHang.add(DonHang.fromJson(donHang));
      }
      return listDonHang;
    } else {
      throw Exception('Server không phản hồi T_T');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _layDonHang(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DonHang> data = snapshot.data!;
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Detail.donHang = data[index];
                          _pageController.jumpToPage(1);
                        },
                        title: Text("Mã đơn: ${data[index].maDonHang}"),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(data[index].nguoiNhan),
                            ),
                            Expanded(
                              child: Text(
                                  '${data[index].diaChiQuan}, ${data[index].sdtNguoiNhan}'),
                            ),
                            Expanded(
                              child: Text(data[index].tenTrangThai!),
                            ),
                          ],
                        ),
                        subtitle: const SizedBox(
                          height: 2,
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
