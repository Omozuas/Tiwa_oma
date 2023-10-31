import 'dart:convert';
import 'package:Tiwa_Oma/view/config.dart';
import 'package:Tiwa_Oma/services/model/review_model.dart';
import 'package:http/http.dart' as http;

class ReviewApi {
  static Future<List<ReviewModel>> fetchUserData(
      String token, String stylistId) async {
    const url = 'http://192.168.137.188:5000/';
    var getReviewFromClientToStylist =
        "${url}review/stylist/${stylistId}/clients/display";
    final response = await http.get(
      Uri.parse(getReviewFromClientToStylist),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}",
      },
    );

    // if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print(responseData);
    final results = responseData['data'] as List<dynamic>;
    final reviewmodeluser = results.map((e) {
      final userId = ReviewName(
        accountType: e['userId']['accountType'],
        profileImg: e['userId']['profileImg'],
        number: e['userId']['number'],
        username: e['userId']['username'],
        country: e['userId']['country'],
        email: e['userId']['email'],
        address: e['userId']['address'],
        state: e['userId']['state'],
        gender: e['userId']['gender'],
        id: e['userId']['id'],
      );
      return ReviewModel(
          rating: e['rating'],
          feedback: e['feedback'],
          userId: userId,
          category: e['category']);
    }).toList();
    return reviewmodeluser;
  }

  static Future<List<AvrageReview>> fetchAvarageReview(
      String token, String stylistId) async {
    const url = 'http://192.168.137.188:5000/';
    var getReviewFromClientToStylist =
        "${url}review/average-rating-by-stylist/${stylistId}";
    final response = await http.get(
      Uri.parse(getReviewFromClientToStylist),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}",
      },
    );

    // if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print(responseData);
    final results = responseData['data'] as List<dynamic>;
    final reviewmodeluser = results.map((e) {
      return AvrageReview(
        avgRating: e['avgRating'],
      );
    }).toList();
    return reviewmodeluser;
  }

  static Future<List<ReviewModel>> fetch1UserData(
      String token, String userId) async {
    const url = 'http://192.168.137.188:5000/';
    var getReviewFromClient = "${url}review//getsendReview/client/${userId}";
    final response = await http.get(
      Uri.parse(getReviewFromClient),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}",
      },
    );

    // if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print(responseData);
    final results = responseData['data'] as List<dynamic>;
    final reviewmodeluser = results.map((e) {
      final userId = ReviewName(
        accountType: e['userId']['accountType'],
        profileImg: e['userId']['profileImg'],
        number: e['userId']['number'],
        username: e['userId']['username'],
        country: e['userId']['country'],
        email: e['userId']['email'],
        address: e['userId']['address'],
        state: e['userId']['state'],
        gender: e['userId']['gender'],
        id: e['userId']['id'],
      );
      return ReviewModel(
          rating: e['rating'],
          feedback: e['feedback'],
          userId: userId,
          category: e['category']);
    }).toList();
    return reviewmodeluser;
  }
}
