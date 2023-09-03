import 'dart:convert';

import 'package:Tiwa_Oma/services/signUpOTp.dart';
import 'package:Tiwa_Oma/view/config.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();
  static Future<OtpSigupresopnsMole> registerOpt(
    String email,
  ) async {
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
}
