import 'dart:convert';
// import 'dart:js';

// import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
import 'package:Tiwa_Oma/services/signUpOTp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import '../client/views/dashboard.view.dart';

class Api {
  static const baseeuri = 'http://192.168.233.188:/';

  static Future<SigupresopnsMole> addUser(Map registerBody) async {
    var url = Uri.parse("${baseeuri}auth/register");

    var res = await http.post(url,
        headers: {'Content-Type': "application/json"},
        body: jsonEncode(registerBody));
    print(res);
    if (res.statusCode == 200) {
      var jsonres = jsonDecode(res.body);
      print(jsonres['success']);
      // print(jsonres['token']);
      // print(registerBody);
      // print(jsonres);
    } else {
      print('failed to register user');
    }

    return wSigupresopnsMole(res.body);
  }

  // static loginUser(Map loginBody) async {
  //   late final SharedPreferences pref;

  //   void initSharedpref() async {
  //     pref = await SharedPreferences.getInstance();
  //   }

  //   @override
  //   void initState() {
  //     initSharedpref();
  //   }

  //   var url = Uri.parse("${baseeuri}auth/login");
  //   try {
  //     final res = await http.post(url,
  //         headers: {'Content-Type': "application/json"},
  //         body: jsonEncode(loginBody));
  //     print(res);
  //     if (res.statusCode == 200) {
  //       var jsonres = jsonDecode(res.body);
  //       var myToken = jsonres['token'];
  //       pref.setString('token', myToken);

  //       print(jsonres['status']);
  //       print(loginBody);

  //       print(jsonres);
  //     } else {
  //       print('failed to login user');
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  static getUser() async {
    var url = Uri.parse("${baseeuri}/auth/:userId");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data);
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }
}
