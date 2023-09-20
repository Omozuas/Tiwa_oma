import 'package:Tiwa_Oma/view/RegisterAs.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: prefs.getString('token'),
  ));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Tiwa Oma',
        debugShowCheckedModeBanner: false,
        home:
            // (token != null && !JwtDecoder.isExpired(token) == false)
            //     ? Dashboard(token: token)
            //     :
            RegisterAsView());
  }
}
