import 'package:delivery/Entities/DonHang.dart';
import 'package:delivery/screens/body/Detail.dart';
import 'package:delivery/screens/body/Info.dart';
import 'package:delivery/screens/body/Scan.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'body/Home.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({super.key});

  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          title = 'Danh sách đơn hàng';
          break;
        case 1:
          title = 'Chi tiết đơn hàng';
          break;
        case 2:
          title = 'Quét';
          break;
        case 3:
          title = 'Cá nhân';
          break;
        default:
          title = "Lỗi";
          break;
      }
    });
  }


  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  var _currentIndex = 0;
  String subtitle = "";
  String title = "Danh sách đơn hàng";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            Home(_pageController),
            const Detail(),
            Scan(_pageController),
            const Info(),
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Trang chủ"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.info),
              title: const Text("Chi tiết"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.qr_code),
              title: Text(title),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: Text(title),
            ),
          ],
        ));
  }
}
