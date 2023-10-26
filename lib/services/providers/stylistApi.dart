import 'dart:convert';

import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:Tiwa_Oma/view/config.dart';
import 'package:http/http.dart' as http;

class StylistApi {
  static Future<List<StylistModel>> fetchStylistData(String token) async {
    final response = await http.get(
      Uri.parse(getAllStylist),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}",
      },
    );

    final stylistResponseData = jsonDecode(response.body);
    print(stylistResponseData);
    final result = stylistResponseData['stylist'] as List<dynamic>;
    final stylistModelUser = result.map((e) {
      return StylistModel(
        accountType: e['accountType'],
        profileImg: e['profileImg'],
        number: e['number'],
        username: e['username'],
        country: e['country'],
        email: e['email'],
        address: e['address'],
        state: e['state'],
        gender: e['gender'],
        id: e['id'],
      );
    }).toList();
    return stylistModelUser;
  }

  static Future<List<StylistModel>> fetchSearchedStylistData(
      String token, name) async {
    const url = 'http://192.168.247.188:5000/';
    var searchStylist = "${url}auth/find/search/$name";
    final response = await http.get(
      Uri.parse(searchStylist),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}",
      },
    );

    final stylistResponseData = jsonDecode(response.body);
    print(stylistResponseData);
    final result = stylistResponseData['data'] as List<dynamic>;
    final stylistModelUser = result.map((e) {
      return StylistModel(
        accountType: e['accountType'],
        profileImg: e['profileImg'],
        number: e['number'],
        username: e['username'],
        country: e['country'],
        email: e['email'],
        address: e['address'],
        state: e['state'],
        gender: e['gender'],
        id: e['id'],
      );
    }).toList();
    return stylistModelUser;
  }
}
