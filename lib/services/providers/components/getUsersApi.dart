import 'dart:convert';

import 'package:Tiwa_Oma/services/booking_respons_service.dart';
import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:http/http.dart' as http;

class GetUsers {
  static Future<ReviewpresopnsMole> fetchStylistData(
      String token, stylistId) async {
    const url = 'http://192.168.178.188:5000/';
    var getUserById = "${url}auth/find/${stylistId}";
    final response = await http.get(
      Uri.parse(getUserById),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}",
      },
    );
    if (response.statusCode == 200) {
      var jsonres = jsonDecode(response.body);
    }

    return reviewresopnsMole(response.body);
  }
}
