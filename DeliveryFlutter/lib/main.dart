import 'package:delivery/Entities/User.dart';
import 'package:delivery/screens/BodyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:delivery/screens/LoginScreen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:async';
import 'dart:developer';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(DeliveryApp());
}

Future<Widget> checkLogin() async {
  bool result = await SessionManager().containsKey("loggedIn");
  if (result) {
    return const BodyScreen();
  }
  return LoginScreen();
}

class MyAppState extends ChangeNotifier {}

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 116, 184, 39)),
      ),
      home: FutureBuilder(
        future: checkLogin(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            FlutterNativeSplash.remove();
            return snapshot.requireData;
          }
          FlutterNativeSplash.remove();
          return const Placeholder();
        }),
      ),
    );
  }
}
