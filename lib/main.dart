import 'package:Tiwa_Oma/admin/adminBooking.dart';
import 'package:Tiwa_Oma/admin/adminCostormers.dart';
import 'package:Tiwa_Oma/admin/adminDashboard.dart';
import 'package:Tiwa_Oma/client/views/clientNotification.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
import 'package:Tiwa_Oma/client/views/seeStylistLocation.view.dart';
import 'package:Tiwa_Oma/firebase_options.dart';
import 'package:Tiwa_Oma/services/firebasApi.dart';
import 'package:Tiwa_Oma/services/updateApi.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:Tiwa_Oma/view/RegisterAs.view.dart';
import 'package:Tiwa_Oma/view/Splash.view.dart';
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
  print("fcmtoken $fcmToken");
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
      home: SeeLocationOfStylist(
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0ZjUzYzgxMzgyY2I1ZGYyNjAzZTNlNiIsImVtYWlsIjoiaXlhbnVvbW96dWFAZ21haWwuY29tIiwidXNlcm5hbWUiOiJKdWRhaHMxMiIsIm51bWJlciI6ODAyMjUzMTM1NywiY291bnRyeSI6Im5pZ2VyaWEiLCJzdGF0ZSI6ImxhZ29zIiwiZ2VuZGVyIjoiZmVtYWxlIiwiYWRkcmVzcyI6IiBlc3RhdGUiLCJwcm9maWxlSW1nIjoiaHR0cDovL3Jlcy5jbG91ZGluYXJ5LmNvbS9kZHhhb2g2cG8vaW1hZ2UvdXBsb2FkL3YxNjk2MTg5NDIzL3VzZXJQcm9maWxJbWcvZW1vdmY1bGdmZmV1cnhjeG5wZGMud2VicCIsImFjY291bnRUeXBlIjoiY2xpZW50IiwiZmlyZWJhc2VUb2tlbiI6ImZneG5mVnRDUjRxTjJUMGJlTTNHQjk6QVBBOTFiRWMxcnZ2OEpUeGRiWGJGV2ZJRThHY0F3bzdHdzFBWTl4QXcwVXZHN0VvWFBFdng3TlNmbHVVY1JOR3djOFM1dTFaVFJ1cU9OM1hTQTRXQlMyb3pjTDU4aGxwYlozYVFhUkpzMGN4S09RQ2hpb0h6aE5wbm16RTk5cnVOZ2g3SE44WWt0REEiLCJpYXQiOjE2OTc1NDM5NDQsImV4cCI6MTY5ODIzNTE0NH0.kIKyePBPu4jCHdgikVIF48sC7e7ym6YDcinoGScs764",
      ),
      // (token != null && !JwtDecoder.isExpired(token) == false)
      //     ? AdminBooking(
      //         token: token,
      //       )
      //     // Dashboard(token: token)
      //     :
      //     Login(),
      // // SplashView(),
      routes: {
        ClientNotification.route: (context) => ClientNotification(
              token: token,
            )
      },
    );
  }
}
