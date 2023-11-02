import 'dart:convert';

import 'package:Tiwa_Oma/services/booking_respons_service.dart';
import 'package:Tiwa_Oma/services/signUpOTp.dart';

import 'package:Tiwa_Oma/view/config.dart';

import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import '../client/views/dashboard.view.dart';

class Api {
  static Future<SigupresopnsMole> addUser(Map registerBody) async {
    var url = Uri.parse(registration);

    var res = await http.post(url,
        headers: {'Content-Type': "application/json"},
        body: jsonEncode(registerBody));
    print(res);
    if (res.statusCode == 200) {
      var jsonres = jsonDecode(res.body);
      print(jsonres['message']);
      // print(jsonres['token']);
      // print(registerBody);
      // print(jsonres);
    } else {
      print('failed to register user');
    }

    return wSigupresopnsMole(res.body);
  }

  static Future<ReviewpresopnsMole> reviewgApp(Map sendReviewBody) async {
    var url = Uri.parse(sendReview);
    var respons = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(sendReviewBody));
    print(respons);
    if (respons.statusCode == 200) {
      var jsonres = jsonDecode(respons.body);
      print(jsonres['success']);
      print(jsonres['token']);
      // print(registerBody);
      print(jsonres);
    } else {
      print('failed to register user');
    }
    return reviewresopnsMole(respons.body);
  }

  static Future<GetreviewpresopnsMole> getreviewgApp() async {
    var url = Uri.parse(getReviewFromClientToStylist);

    var respons = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    print(respons);
    if (respons.statusCode == 200) {
      var jsonres = jsonDecode(respons.body);
      // print(jsonres['success']);
      // print(jsonres['token']);
      // print(jsonres['data'] as List);

      // print(jsonres);
    } else {
      print('failed to get review');
    }
    return getreviewresopnsMole(respons.body);
  }

  static Future<OtpTransactionresopnsMole> transactionOtp(number) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var trsactionotp = "${url}apiTermiiOtp/sentOtp";
    var respons = Uri.parse(trsactionotp);
    print(number);
    var res = await http.post(respons,
        headers: {'Content-Type': "application/json"},
        body: jsonEncode(number));
    print(res);
    if (res.statusCode == 200) {
      var jsonres = jsonDecode(res.body);
      print(jsonres);
      // print(jsonres['token']);
      // print(registerBody);
      // print(jsonres);
    } else {
      print('failed to register user');
    }

    return otpTransactionresopnsMole(res.body);
  }

  static Future<OtpTransactionVerifyresopnsMole> verifyTransactionOtp(
      number) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var trsactionotp = "${url}apiTermiiOtp/verfySentOtp";
    var respons = Uri.parse(trsactionotp);
    print(number);
    var res = await http.post(respons,
        headers: {'Content-Type': "application/json"},
        body: jsonEncode(number));
    print(res);
    if (res.statusCode == 200) {
      var jsonres = jsonDecode(res.body);
      print(jsonres);
      // print(jsonres['token']);
      // print(registerBody);
      // print(jsonres);
    } else {
      print('failed to register user');
    }

    return otpTransactionVerifyresopnsMole(res.body);
  }

  static Future<ChangePasswordresopnsMole> changePassword(
      number, registerBody) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var restPssword = "${url}auth/users/${number}/password";
    var respons = Uri.parse(restPssword);
    print(number);
    print(registerBody);
    var res = await http.put(respons,
        headers: {'Content-Type': "application/json"},
        body: jsonEncode(registerBody));
    print(res);
    if (res.statusCode == 200) {
      var jsonres = jsonDecode(res.body);
      print(jsonres);
      // print(jsonres['token']);
      // print(registerBody);
      // print(jsonres);
    } else {
      print('failed to register user');
    }

    return changePasswordRes(res.body);
  }

  static Future<ChangePasswordres1opnsMole> changePassword1(number) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var restPssword = "${url}auth/users/${number}";
    var respons = Uri.parse(restPssword);
    print(number);

    var res = await http.get(
      respons,
      headers: {'Content-Type': "application/json"},
    );
    print(res);
    if (res.statusCode == 200) {
      var jsonres = jsonDecode(res.body);
      print(jsonres);
      // print(jsonres['token']);
      // print(registerBody);
      // print(jsonres);
    } else {
      print('failed to register user');
    }

    return changePasswordRes1(res.body);
  }
}
