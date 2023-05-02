import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce_app/account/forgotPassword/stepFinal.dart';
import 'package:flutter_ecommerce_app/connectivity/test_connexion.dart';
import 'package:flutter_ecommerce_app/pages/cart/refresh_card_back.dart';
import 'package:flutter_ecommerce_app/pages/orders.dart';

import 'package:flutter_ecommerce_app/pages/home_page.dart';
import 'package:flutter_ecommerce_app/pages/splashscreen.dart';
import 'package:flutter_ecommerce_app/pages/test_bar.dart';

import 'package:get/get.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(fontFamily: 'Gotham'),
        defaultTransition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 500),
        debugShowCheckedModeBanner: false,
        title: 'E-commerce',
        home: SplashScreen());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
