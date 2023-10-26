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

OtpTransactionresopnsMole otpTransactionresopnsMole(String str) =>
    OtpTransactionresopnsMole.fromJson(json.decode(str));

class OtpTransactionresopnsMole {
  OtpTransactionresopnsMole(
      {required this.message,
      required this.data,
      required this.data1,
      required this.otp,
      required this.pin_id});

  late final String message;
  late final data;
  late final data1;
  late final otp;
  late final pin_id;

  OtpTransactionresopnsMole.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    otp = data["otp"];
    pin_id = data['pin_id'];
  }
}

OtpTransactionVerifyresopnsMole otpTransactionVerifyresopnsMole(String str) =>
    OtpTransactionVerifyresopnsMole.fromJson(json.decode(str));

class OtpTransactionVerifyresopnsMole {
  OtpTransactionVerifyresopnsMole({
    required this.message,
    required this.data,
    required this.verified,
  });

  late final String message;
  late final data;

  late final verified;

  OtpTransactionVerifyresopnsMole.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    verified = data["verified"];
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

UpdateResopnsMole updateResopnsMole(String str) =>
    UpdateResopnsMole.fromJson(json.decode(str));

class UpdateResopnsMole {
  UpdateResopnsMole(
      {required this.data,
      required this.message,
      required this.success,
      required this.token,
      required this.status});

  late final status;
  late final token;

  late final data;
  late final message;

  late final success;

  UpdateResopnsMole.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    token = json['token'];
    status = json['status'];
    message = json['message'];
    success = json['success'];
  }
}

PushNotificationResopnsMole pushNotificationResopnsMole(String str) =>
    PushNotificationResopnsMole.fromJson(json.decode(str));

class PushNotificationResopnsMole {
  PushNotificationResopnsMole(
      {required this.data,
      required this.message,
      required this.success,
      required this.token,
      required this.status});

  late final status;
  late final token;

  late final data;
  late final message;

  late final success;

  PushNotificationResopnsMole.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    token = json['token'];
    status = json['status'];
    message = json['message'];
    success = json['success'];
  }
}

AdminRecResopnsMole adminResopnsMole(String str) =>
    AdminRecResopnsMole.fromJson(json.decode(str));

class AdminRecResopnsMole {
  AdminRecResopnsMole(
      {required this.data,
      required this.uniqueStylistIds,
      required this.success,
      required this.uniqueUserIds,
      required this.totalBooking});

  late final totalBooking;
  late final uniqueUserIds;

  late final data;
  late final uniqueStylistIds;

  late final success;

  AdminRecResopnsMole.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    uniqueUserIds = data['uniqueUserIds'];
    totalBooking = data['totalBooking'];
    uniqueStylistIds = data['uniqueStylistIds'];
    success = json['success'];
  }
}

ChangePasswordresopnsMole changePasswordRes(String str) =>
    ChangePasswordresopnsMole.fromJson(json.decode(str));

class ChangePasswordresopnsMole {
  ChangePasswordresopnsMole({required this.message});

  late final String message;

  ChangePasswordresopnsMole.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
