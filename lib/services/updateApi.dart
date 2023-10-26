import 'dart:convert';

import 'package:Tiwa_Oma/services/signUpOTp.dart';
import 'package:http/http.dart' as http;

class UpdateuserInfoApi {
  static Future<UpdateResopnsMole> updateUser(
      Map updateUser, token, stylistId) async {
    const url = 'http://192.168.247.188:5000/';
    var updateUserInfo = "${url}auth/update/${stylistId}";

    final respons =
        await http.put(Uri.parse(updateUserInfo), body: updateUser, headers: {
      // "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    print(respons);
    if (respons.statusCode == 200) {
      var jsonres = jsonDecode(respons.body);
      print(jsonres['data']);
      // print(jsonres['token']);
      // print(registerBody);
      // print(jsonres);
    } else {
      print('failed to update user');
    }

    return updateResopnsMole(respons.body);
  }

  static Future<UpdateResopnsMole> updateUserImg(
      String imgUrl, token, stylistId) async {
    const url = 'http://192.168.247.188:5000/';
    var updateUserInfo = "${url}auth/update/progilImg/${stylistId}";
    print(token);
    final respons = await http.post(Uri.parse(updateUserInfo), body: {
      "profileImg": imgUrl
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

    return updateResopnsMole(respons.body);
  }

  static Future<UpdateResopnsMole> updateUserDeviceToken(
      String firebaseToken, token, stylistId) async {
    const url = 'http://192.168.247.188:5000/';
    var updateUserInfo = "${url}auth/update/deviceToken/${stylistId}";
    print(firebaseToken);
    final respons = await http.put(Uri.parse(updateUserInfo), body: {
      "firebaseToken": firebaseToken
    }, headers: {
      // "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    print(respons);
    if (respons.statusCode == 200) {
      Map<String, dynamic> jsonres = jsonDecode(respons.body);
      print('dataDevicetoken${jsonres['data']}');
      // print(jsonres['token']);
      // print(registerBody);
      // print(jsonres);
    } else {
      print('failed to update deviceToken user');
    }

    return updateResopnsMole(respons.body);
  }
}
