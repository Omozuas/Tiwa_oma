import 'dart:convert';
import 'package:Tiwa_Oma/services/booking_respons_service.dart';
import 'package:Tiwa_Oma/services/signUpOTp.dart';
import 'package:Tiwa_Oma/view/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();
  static Future<OtpSigupresopnsMole> registerOpt(String email) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    // var url = Uri.http(SendMail);

    var respons = await client.post(Uri.parse(SendMail),
        headers: requestHeaders,
        body: jsonEncode({
          'email': email,
        }));
    return otpSigupresopnsMole(respons.body);
  }

  static Future<OtpSigupresopnsMole> verifyOtp(
      String email, String otpHash, String otpcode) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    // var url = Uri.http(verifyMail);

    var respons = await client.post(Uri.parse(verifyMail),
        headers: requestHeaders,
        body: jsonEncode({'email': email, "otp": otpcode, "hash": otpHash}));
    return otpSigupresopnsMole(respons.body);
  }

  static Future<BookingpresopnsMole> bookingApp(bookings, String token) async {
    // var url = Uri.http(verifyMail);

    var respons = await client.post(Uri.parse(bookAppoinment),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token}",
        },
        body: jsonEncode(bookings));
    print(bookings);
    if (respons.statusCode == 200) {
      Map<String, dynamic> jsonres = jsonDecode(respons.body);
      print(jsonres);
      // print(jsonres['token']);
      // print(registerBody);
      print(jsonres);
    } else {
      // var jsonres = jsonDecode(respons.body);
      print('failed to book Appoinmewnt');
    }
    return bookingresopnsMole(respons.body);
  }

  static Future<PostNotificationresopnsMole> postNotification(
      bookings, String token) async {
    const url = 'http://192.168.178.188:5000/';
    var postNotifyBooking = "${url}notification/sendNotify";

    var respons = await http.post(Uri.parse(postNotifyBooking),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token}",
        },
        body: jsonEncode(bookings));
    print(bookings);
    if (respons.statusCode == 200) {
      Map<String, dynamic> jsonres = jsonDecode(respons.body);
      print(jsonres);
      // print(jsonres['token']);
      // print(registerBody);
      print(jsonres);
    } else {
      // var jsonres = jsonDecode(respons.body);
      print('failed to book postNotification');
    }
    return postNotifyresopnsMole(respons.body);
  }

  static Future<BookingpresopnsMole> updateBookingApp(
      updateBookings, String token) async {
    const url = 'http://192.168.178.188:5000/';
    var updateBooking = "${url}bookings//bookings/find/updateTransaction";

    var respons = await client.put(Uri.parse(updateBooking),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token}",
        },
        body: jsonEncode(updateBookings));
    print(respons);
    if (respons.statusCode == 200) {
      Map<String, dynamic> jsonres = jsonDecode(respons.body);
      print(jsonres['success']);
      // print(jsonres['token']);
      // print(registerBody);
      print(jsonres);
    } else {
      var jsonres = jsonDecode(respons.body);
      print('failed to book Appoinmewnt');
    }
    return bookingresopnsMole(respons.body);
  }
}
