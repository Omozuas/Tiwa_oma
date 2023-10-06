import 'package:Tiwa_Oma/client/views/clientNotification.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
import 'package:Tiwa_Oma/services/firebasApi.dart';
import 'package:Tiwa_Oma/services/updateApi.dart';
import 'package:Tiwa_Oma/view/RegisterAs.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SharedPreferences prefsDevice = await SharedPreferences.getInstance();

  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("fcmtoken$fcmToken");
  prefsDevice.setString('deviceToken', fcmToken!);
  runApp(MyApp(
    token: prefs.getString('token'),
  ));
}

class MyApp extends StatelessWidget {
  final token;

  MyApp({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tiwa Oma',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: (token != null && !JwtDecoder.isExpired(token) == false)
          ? Dashboard(token: token)
          : RegisterAsView(),
      routes: {
        ClientNotification.route: (context) => ClientNotification(
              token: token,
            )
      },
    );
  }
}
