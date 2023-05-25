import 'dart:math';

import 'package:delivery/Entities/ApiHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:delivery/screens/BodyScreen.dart';
import 'package:delivery/Entities/User.dart';

late Future<UserSession> loginNVGH;

class Login extends StatelessWidget {
  Duration get loginTime => const Duration(milliseconds: 2250);
//Đăng nhập

  Future<String?> _authUser(LoginData data) async {
    final response = await http.post(
      Uri.parse('${ApiHelper.ip}/nvgh/dangnhap'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': data.name,
        'password': data.password,
      }),
    );

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['Result'] == 0) {
        await SessionManager().set("user", response.body);
        await SessionManager().set("loggedIn", true);
        UserSession u = UserSession.fromJson(jsonDecode(response.body));
        print(u.tenNhanVien);
        return null;
      }
      if (jsonDecode(response.body)['Result'] == 1) {
        return 'Tên tài khoản không tồn tại';
      }
      return 'Mật khẩu không đúng';
    } else {
      throw Exception('Server không phản hồi T_T');
    }
  }

// Khôi phục mật khẩu
  Future<String> _recoverPassword(String name) {
    return Future(() => 'Chưa có code :)');
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      //Logo
      logo: const AssetImage('assets/logo.png'),
      //Chữ login
      title: 'Delivery',
      //Các message
      messages: LoginMessages(
          userHint: 'Tên đăng nhập',
          passwordHint: 'Mật khẩu',
          loginButton: 'Đăng nhập',
          forgotPasswordButton: 'Quên mật khẩu',
          flushbarTitleError: 'Lỗi khi đăng nhập',
          recoverPasswordButton: 'Khôi phục mật khẩu',
          recoverCodePasswordDescription: 'Nhập email để khôi phục',
          recoverPasswordDescription: ''),
      theme: LoginTheme(
        //nền
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
        //thẻ chứa giao diện đăng nhập
        cardTheme: const CardTheme(
            color: Colors.transparent, elevation: 0, shadowColor: Colors.black),
        //thẻ input
        inputTheme: const InputDecorationTheme(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2302)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2302)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 45, 145, 71),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2302)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 0, 0),
            ),
          ),
          floatingLabelStyle: TextStyle(),
          iconColor: Color.fromARGB(255, 45, 145, 71),
        ),
        //thẻ button
        buttonTheme: const LoginButtonTheme(
            backgroundColor: Color.fromRGBO(45, 145, 71, 1)),
      ),
      //Định dạng đăng nhập bằng username
      userType: LoginUserType.name,
      //Bỏ validate đăng nhập
      userValidator: (value) {
        if (value == "") {
          return 'Vui lòng nhập tài khoản';
        }
        return null;
      },
      passwordValidator: (value) {
        if (value == "") {
          return 'Vui lòng nhập mật khẩu';
        }
        return null;
      },
      onLogin: (data) => _authUser(data),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BodyScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
