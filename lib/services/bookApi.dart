import 'dart:convert';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/services/model/bookingCountt_model.dart';
import 'package:Tiwa_Oma/services/model/review_model.dart';
import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:Tiwa_Oma/services/model/user_model.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class BookingApi {
  static Future<List<BookinModel>> fetchBookingData(
      String? token, String userId1) async {
    const url = 'http://192.168.208.188:5000/';
    var getUserBookings = "${url}bookings/user-reviews/${userId1}";

    final respons = await http.get(Uri.parse(getUserBookings), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    final Map<String, dynamic> responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
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
      final userId2 = ReviewName(
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
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['id']);
      final ratingId = ReviewModel(
          rating: e['rating'],
          feedback: e['feedback'],
          userId: userId2,
          category: e['category']);
      return BookinModel(
          appointmentDate: e['appointmentDate'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentTime'],
          price: e['price'],
          showStatus: e['showStatus'],
          bookingCount: e['bookingCount'],
          userId: userId,
          stylistId: stylistId,
          feature: e['feature'],
          ratingId: ratingId);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel>> fetchBookingDataId(
      String? token, String stylistId) async {
    const url = 'http://192.168.208.188:5000/';
    var getUserBookings = "${url}bookings/stylist/${stylistId}/clients/display";

    final respons = await http.get(Uri.parse(getUserBookings), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    final Map<String, dynamic> responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
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
      final userId2 = ReviewName(
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
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);
      final ratingId = ReviewModel(
          rating: e['rating'],
          feedback: e['feedback'],
          userId: userId2,
          category: e['category']);
      return BookinModel(
          appointmentDate: e['appointmentDate'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          price: e['price'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: stylistId,
          feature: e['feature'],
          bookingCount: e['bookingCount'],
          ratingId: ratingId);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel2>> fetchBookingDataIdDetails(
      String? token, String userId) async {
    const url = 'http://192.168.208.188:5000/';
    var getUserBookingsDetails = "${url}bookings/count/user/${userId}";

    final respons = await http.get(Uri.parse(getUserBookingsDetails), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    var responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;
    final results2 = responData['data2'];

    final bookingModelUser = results.map((e) {
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);

      return BookinModel2(
          appointmentDate: e['appointmentDate'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          price: e['price'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: e['stylistId'],
          feature: e['feature'],
          bookingCount: results2,
          ratingId: e['ratingId']);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel2>> fetchBookingDataIdUserId(
      String? token, String stylistId) async {
    const url = 'http://192.168.208.188:5000/';
    var getUserBookingsUserId =
        "${url}bookings/togetid/stylist/${stylistId}/users";

    final respons = await http.get(Uri.parse(getUserBookingsUserId), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    var responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final userId = UserModel(
          username: e['username'],
          profileImg: e['profileImg'],
          email: e['email'],
          address: e['address'],
          state: e['state'],
          country: e['country'],
          gender: e['gender'],
          accountType: e['accountType'],
          number: e['number'],
          id: e['_id']);

      return BookinModel2(
          appointmentDate: e['appointmentDate'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          price: e['price'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: e['stylistId'],
          feature: e['feature'],
          bookingCount: e['bookingCount'],
          ratingId: e['ratingId']);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel2>> fetchBookingDataIdFrequentUserId(
      String? token, String stylistId) async {
    const url = 'http://192.168.208.188:5000/';
    var getUserBookingsUserId =
        "${url}bookings/togetid/stylist/${stylistId}/most-frequent-user";

    final respons = await http.get(Uri.parse(getUserBookingsUserId), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    var responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);

      return BookinModel2(
          appointmentDate: e['appointmentDate'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          price: e['price'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: e['stylistId'],
          feature: e['feature'],
          bookingCount: e['bookingCount'],
          ratingId: e['ratingId']);
    }).toList();
    return bookingModelUser;
  }
}
