import 'dart:convert';
import 'package:Tiwa_Oma/services/signUpOTp.dart';
import 'package:http/http.dart' as http;

class AdminApi {
  static Future<AdminRecResopnsMole> fetchAllDataRecords(String? token) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
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
