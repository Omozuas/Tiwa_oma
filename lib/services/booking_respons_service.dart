import 'dart:convert';

BookingpresopnsMole bookingresopnsMole(String str) =>
    BookingpresopnsMole.fromJson(json.decode(str));

class BookingpresopnsMole {
  BookingpresopnsMole(
      {required this.data, required this.success, required this.message});

  late final String message;
  late final data;

  late final success;

  BookingpresopnsMole.fromJson(Map<String, dynamic> json) {
    data = json['data'];

    message = json['message'];

    success = json['success'];
  }
}

ReviewpresopnsMole reviewresopnsMole(String str) =>
    ReviewpresopnsMole.fromJson(json.decode(str));

class ReviewpresopnsMole {
  ReviewpresopnsMole(
      {required this.data,
      this.token,
      required this.success,
      required this.message});

  late final String message;
  late final data;
  late final token;
  late final success;

  ReviewpresopnsMole.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    token = json['token'];
    message = json['message'];

    success = json['success'];
  }
}

GetreviewpresopnsMole getreviewresopnsMole(String str) =>
    GetreviewpresopnsMole.fromJson(json.decode(str));

class GetreviewpresopnsMole {
  GetreviewpresopnsMole(
      {required this.data,
      this.token,
      required this.success,
      required this.message});

  late final String message;
  late final data;
  late final token;
  late final success;

  GetreviewpresopnsMole.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    token = json['token'];
    message = json['message'];

    success = json['success'];
  }
}
