import 'package:Tiwa_Oma/admin/adminDashboard.dart';
import 'package:Tiwa_Oma/client/views/clientNotification.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
import 'package:Tiwa_Oma/client/views/seeStylistLocation.view.dart';
import 'package:Tiwa_Oma/services/firebasApi.dart';
import 'package:Tiwa_Oma/stylist/StylistDashboard.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:Tiwa_Oma/view/RegisterAs.view.dart';
import 'package:Tiwa_Oma/view/Splash.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    runApp(MyApp(
      token: prefs.getString('token'),
    ));
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences prefsDevice = await SharedPreferences.getInstance();

    await Firebase.initializeApp();
    await FirebaseApi().initNotification();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("fcmtoken $fcmToken");
    print("myToken ${prefs.getString('token')}");
    prefsDevice.setString('deviceToken', fcmToken!);
    runApp(MyApp(
      token: prefs.getString('token'),
    ));
  }
}

class MyApp extends StatefulWidget {
  final token;

  MyApp({
    super.key,
    required this.token,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String? accountType = '';
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      accountType = jwtDecodedToken['accountType'];
      print(accountType);
    }
    return GetMaterialApp(
      title: 'Tiwa Oma',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: (widget.token != null && !JwtDecoder.isExpired(widget.token))
          ? (widget.token == null)
              ? RegisterAsView()
              : (accountType == 'client')
                  ? Dashboard(token: widget.token)
                  : (accountType == 'stylist')
                      ? StylistDashboard(token: widget.token)
                      : (accountType == 'admin')
                          ? AdminDashboard(
                              token: widget.token,
                            )
                          : RegisterAsView()
          : const SplashView(),
      routes: {
        ClientNotification.route: (context) => ClientNotification(
              token: widget.token,
            )
      },
    );
  }
}
