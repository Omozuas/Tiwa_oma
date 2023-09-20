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
      print(jsonres['success']);
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
}
