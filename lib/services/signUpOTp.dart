import 'dart:convert';

OtpSigupresopnsMole otpSigupresopnsMole(String str) =>
    OtpSigupresopnsMole.fromJson(json.decode(str));

class OtpSigupresopnsMole {
  OtpSigupresopnsMole({required this.message, required this.data});

  late final String message;
  late final String? data;

  OtpSigupresopnsMole.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }
}

SigupresopnsMole wSigupresopnsMole(String str) =>
    SigupresopnsMole.fromJson(json.decode(str));

class SigupresopnsMole {
  SigupresopnsMole(
      {required this.data,
      required this.token,
      required this.userData,
      required this.success,
      required this.status});

  late final status;
  late final String? data;
  late final userData;

  late final String success;
  late final token;

  SigupresopnsMole.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    token = json['token'];
    status = json['status'];
    userData = json['usersData'];
    success = json['success'];
  }
}
