import 'dart:convert';

import 'package:Tiwa_Oma/services/model/admin_model.dart';
import 'package:Tiwa_Oma/services/signUpOTp.dart';
import 'package:http/http.dart' as http;

class AdminApi {
  static Future<AdminRecResopnsMole> fetchAllDataRecords(String? token) async {
    const url = 'http://192.168.247.188:5000/';
    var getDataRecords = "${url}auth/admin/stats";

    final respons = await http.get(Uri.parse(getDataRecords), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    var responData = jsonDecode(respons.body);
    print(responData);

    return adminResopnsMole(respons.body);
  }
}
