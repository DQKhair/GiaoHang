import 'dart:convert';

import 'package:delivery/Entities/ApiHelper.dart';
import 'package:delivery/Entities/DonHang.dart';
import 'package:delivery/screens/body/Detail.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scan extends StatefulWidget {
  final PageController _pageController;
  const Scan(this._pageController, {super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  Barcode? result;
  DonHang? donHang;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  //Chi tiết đơn hàng
  Future<DonHang> _layChiTietDonHang(id) async {
    final response = await http.post(
      Uri.parse('${ApiHelper.ip}/nvgh/laychitietdonhang/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, int>{
        'id': id,
      }),
    );

    if (response.statusCode == 200) {
      return DonHang.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Server không phản hồi T_T');
    }
  }

  // Xác nhận lấy hàng
  Future<int> _xacNhanDaLayHang(id) async {
    final response = await http.post(
      Uri.parse('${ApiHelper.ip}/nvgh/xacnhanlayhang/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, int>{
        'id': id,
      }),
    );

    if (response.statusCode == 200) {
      dynamic result = jsonDecode(response.body);
      return result["Result"];
    } else {
      throw Exception('Server không phản hồi T_T');
    }
  }

  // Xác nhận đang giao hàng
  Future<int> _xacNhanDangGiaoHang(id) async {
    final response = await http.post(
      Uri.parse('${ApiHelper.ip}/nvgh/xacnhandanggiaohang/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, int>{
        'id': id,
      }),
    );

    if (response.statusCode == 200) {
      dynamic result = jsonDecode(response.body);
      return result["Result"];
    } else {
      throw Exception('Server không phản hồi T_T');
    }
  }

  // Xác nhận đã giao hàng
  Future<int> _xacNhanDaGiaoHang(id) async {
    final response = await http.post(
      Uri.parse('${ApiHelper.ip}/nvgh/xacnhandagiaohang/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, int>{
        'id': id,
      }),
    );
    if (response.statusCode == 200) {
      dynamic result = jsonDecode(response.body);
      return result["Result"];
    } else {
      throw Exception('Server không phản hồi T_T');
    }
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Mã đơn hàng: ${donHang!.maDonHang} | Tên: ${donHang!.nguoiNhan} | ${donHang!.tenTrangThai}')
                  else
                    const Text('Quét mã để xử lí'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                if (snapshot.data == true) {
                                  return const Text('Đèn: bật');
                                } else {
                                  return const Text('Đèn: tắt');
                                }
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  String camInfo;
                                  if (describeEnum(snapshot.data!) == "front") {
                                    camInfo = "trước";
                                  } else {
                                    camInfo = "sau";
                                  }
                                  return Text('Đang dùng camera $camInfo');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  if (result != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if (donHang!.maTrangThai == 4)
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () {},
                              onLongPress: () async {
                                int result =
                                    await _xacNhanDaLayHang(donHang!.maDonHang);
                                if (result != -1) {
                                  donHang!.tenTrangThai = 'Đã lấy hàng';
                                  donHang!.maTrangThai = 5;
                                  setState(() {});
                                }
                              },
                              child: const Text('Xác nhận lấy hàng',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        if (donHang!.maTrangThai == 5)
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () {},
                              onLongPress: () async {
                                int result = await _xacNhanDangGiaoHang(
                                    donHang!.maDonHang);
                                if (result != -1) {
                                  donHang!.tenTrangThai = 'Đang giao hàng';
                                  donHang!.maTrangThai = 6;
                                  setState(() {});
                                }
                              },
                              child: const Text('Xác nhận đang giao',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        if (donHang!.maTrangThai == 6)
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () {},
                              onLongPress: () async {
                                int result = await _xacNhanDaGiaoHang(
                                    donHang!.maDonHang);
                                if (result != -1) {
                                  donHang!.tenTrangThai = 'Đã giao hàng';
                                  donHang!.maTrangThai = 7;
                                  setState(() {});
                                }
                              },
                              child: const Text('Xác nhận đã giao',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () {
                              Detail.donHang = donHang;
                              widget._pageController.jumpToPage(1);
                            },
                            child: const Text('chi tiết',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller?.resumeCamera();
                              setState(() {
                                result = null;
                                donHang = null;
                              });
                            },
                            child: const Text('quét lại',
                                style: TextStyle(fontSize: 20)),
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 222.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      if (describeEnum(scanData.format) == 'qrcode') {
        try {
          await controller?.pauseCamera();
          DonHang dh =
              await _layChiTietDonHang(int.parse(scanData.code.toString()));
          setState(() {
            result = scanData;
            donHang = dh;
          });
          // ignore: empty_catches
        } catch (e) {
          result = null;
          controller.resumeCamera();
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
