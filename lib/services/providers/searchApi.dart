import 'dart:convert';
import 'package:Tiwa_Oma/services/model/vendo_Model.dart';

import 'package:http/http.dart' as http;
import 'package:Tiwa_Oma/services/model/stylist_model.dart';

class SearchApi {
  static Future<List<VendorModel>> fetchSearchStylistData(
      String token, searchQuery) async {
    const url = 'http://192.168.178.188:5000/';
    var searchStylist = "${url}vendors/find/search/$searchQuery";
    final response = await http.get(
      Uri.parse(searchStylist),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}",
      },
    );

    final stylistResponseData = jsonDecode(response.body);
    print(stylistResponseData);
    if (response.statusCode == 200) {
      final results = stylistResponseData['data'] as List<dynamic>;
      final vendorModelStylist = results.map((e) {
        final stylistId = StylistModel(
            username: e['stylistId']['username'],
            profileImg: e['stylistId']['profileImg'],
            email: e['stylistId']['email'],
            address: e['stylistId']['address'],
            state: e['stylistId']['state'],
            country: e['stylistId']['country'],
            gender: e['stylistId']['gender'],
            accountType: e['stylistId']['accountType'],
            number: e['stylistId']['number'],
            id: e['stylistId']['id']);

        return VendorModel(
            stylistModel: stylistId,
            hairStlye: e['nameOfHairStyle'],
            category: e['category'],
            hairStyleImg: e['hairStyleiImages'],
            hartPrice: e['priceOfHairStyle']);
      }).toList();
      return vendorModelStylist;
    } else {
      return [];
    }
  }
}
