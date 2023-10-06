import 'dart:convert';

BookingpresopnsMole bookingresopnsMole(String str) =>
    BookingpresopnsMole.fromJson(json.decode(str));

class BookingpresopnsMole {
  BookingpresopnsMole(
      {required this.data,
      required this.success,
      required this.message,
      required this.client_secret,
      required this.bookingId,
      required this.paymentIntentId,
      required this.stripeCostormerId,
      required this.cardId});

  late final String message;
  late final data;
  late final paymentIntentId;
  late final client_secret;
  late final bookingId;
  late final stripeCostormerId;
  late final cardId;
  late final success;

  BookingpresopnsMole.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    cardId = data['cardId'];
    client_secret = data['client_secret'];
    paymentIntentId = data['paymentIntentId'];
    bookingId = data['bookingId'];
    stripeCostormerId = data['stripeCostormerId'];
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
