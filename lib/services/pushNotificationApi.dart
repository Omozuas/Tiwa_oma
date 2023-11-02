import 'dart:convert';
import 'package:Tiwa_Oma/services/signUpOTp.dart';
import 'package:http/http.dart' as http;

class PushNotificationApi {
  static Future<PushNotificationResopnsMole> pushNotificationPin(
      String imgUrl, String des, token, firebasToken) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var updateUserInfo = "${url}apiFireNotFiy/sendFN";
    print(token);
    final respons = await http.post(Uri.parse(updateUserInfo), body: {
      "title": imgUrl,
      "body": "This Is Your One-Time_Pin DO NOT DISCLOSE IT $des",
      "fireBaseToken": firebasToken
    }, headers: {
      // "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    print(respons);
    if (respons.statusCode == 200) {
      Map<String, dynamic> jsonres = jsonDecode(respons.body);
      print('dataimg${jsonres['data']}');
      // print(jsonres['token']);
      // print(registerBody);
      // print(jsonres);
    } else {
      print('failed to update profileImg user');
    }

    return pushNotificationResopnsMole(respons.body);
  }

  static Future<PushNotificationResopnsMole> pushNotificationBookingingForUser(
      String des, token, firebasToken) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var updateUserInfo = "${url}apiFireNotFiy/sendFN";
    print(token);
    final respons = await http.post(Uri.parse(updateUserInfo), body: {
      "title": "Succes Booking",
      "body": "Booked an appointment with $des",
      "fireBaseToken": firebasToken
    }, headers: {
      // "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    print(respons);
    if (respons.statusCode == 200) {
      Map<String, dynamic> jsonres = jsonDecode(respons.body);
      print('dataimg${jsonres['data']}');
      // print(jsonres['token']);
      // print(registerBody);
      // print(jsonres);
    } else {
      print('failed to update profileImg user');
    }

    return pushNotificationResopnsMole(respons.body);
  }

  static Future<PushNotificationResopnsMole>
      pushNotificationBookingingForStylist(
          String des, token, firebasToken) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var updateUserInfo = "${url}apiFireNotFiy/sendFN";
    print(token);
    final respons = await http.post(Uri.parse(updateUserInfo), body: {
      "title": "A CLIENT JUST booked",
      "body": "Appointment with $des",
      "fireBaseToken": firebasToken
    }, headers: {
      // "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    print(respons);
    if (respons.statusCode == 200) {
      Map<String, dynamic> jsonres = jsonDecode(respons.body);
      print('dataimg${jsonres['data']}');
      // print(jsonres['token']);
      // print(registerBody);
      // print(jsonres);
    } else {
      print('failed to update profileImg user');
    }

    return pushNotificationResopnsMole(respons.body);
  }
}
