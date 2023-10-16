import 'dart:convert';

import 'package:Tiwa_Oma/services/model/notification_model.dart';
import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:Tiwa_Oma/services/model/user_model.dart';
import 'package:http/http.dart' as http;

class NotificationApi {
  static Future<List<NotificationModel>> fetchBookingById(
      String? token, String id) async {
    const url = 'http://192.168.178.188:5000/';
    var getNotificationUserId = "${url}notification/getnofication/client/${id}";

    final respons = await http.get(Uri.parse(getNotificationUserId), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    var responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;
    print(results);
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

      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          stripeCostormerId: e['userId']['stripeCostormerId'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);

      return NotificationModel(
        bookingDate: e['bookingDate'],
        bookingTime: e['bookingTime'],
        userModel: userId,
        stylistModel: stylistId,
        bookingId: e['bookingId'],
      );
    }).toList();
    return bookingModelUser;
  }

  static Future<List<NotificationModel>> fetchBookingStylistById(
      String? token, String id) async {
    const url = 'http://192.168.178.188:5000/';
    var getNotificationUserId =
        "${url}notification/getnofication/stylist/${id}";

    final respons = await http.get(Uri.parse(getNotificationUserId), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    var responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;
    print(results);
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

      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          stripeCostormerId: e['userId']['stripeCostormerId'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);

      return NotificationModel(
        bookingDate: e['bookingDate'],
        bookingTime: e['bookingTime'],
        userModel: userId,
        stylistModel: stylistId,
        bookingId: e['bookingId'],
      );
    }).toList();
    return bookingModelUser;
  }
}
