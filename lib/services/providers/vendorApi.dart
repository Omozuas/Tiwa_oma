import 'dart:convert';

import 'package:Tiwa_Oma/services/booking_respons_service.dart';
import 'package:Tiwa_Oma/services/model/review_model.dart';
import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:Tiwa_Oma/services/model/vendo_Model.dart';
import 'package:Tiwa_Oma/view/config.dart';
import 'package:http/http.dart' as http;

class VendorApi {
  static Future<GetreviewpresopnsMole> uploadVendorDetails(
      String? token, stylistId, uploadinfo) async {
    const url = 'http://192.168.247.188:5000/';
    var uploadVendorDetails = "${url}vendors/vendor/upload/${stylistId}";
    final respons = await http.post(Uri.parse(uploadVendorDetails),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}",
        },
        body: jsonEncode(uploadinfo));

    return getreviewresopnsMole(respons.body);
  }

  static Future<List<VendorModel>> fetchVendorData(
      String? token, String stylistId) async {
    const url = 'http://192.168.247.188:5000/';
    var getVendorById = "${url}vendors/getVendorsbyId/${stylistId}";

    final response = await http.get(
      Uri.parse(getVendorById),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}",
      },
    );
    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final results = responseData['data'] as List<dynamic>;
      final results2 = responseData['data2'];
      print(results2);
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
            hartPrice: e['priceOfHairStyle'],
            avgRating: results2);
      }).toList();
      return vendorModelStylist;
    } else {
      return [];
    }
  }

  static Future<List<VendorModel>> fetchVendorDataImg(
    String? token,
  ) async {
    const url = 'http://192.168.247.188:5000/';
    var getVendorImg = "${url}vendors/randomImagesAndPrices";

    final response = await http.get(
      Uri.parse(getVendorImg),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}",
      },
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    print(responseData);
    if (response.statusCode == 200) {
      final results = responseData['data'] as List<dynamic>;
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
            id: e['stylistId']['_id']);

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
