import 'package:Tiwa_Oma/services/model/review_model.dart';

class Stylistddetailinfo {
  final String username;
  final String email;
  final String address;
  final String state;
  final String country;
  final String gender;
  final number;
  final String accountType;

  Stylistddetailinfo(
      {required this.email,
      required this.address,
      required this.state,
      required this.country,
      required this.gender,
      required this.number,
      required this.accountType,
      required this.username});
}

class Stylistreviwe {
  final String feedback;
  final rating;
  final ReviewName userId;
  final category;

  Stylistreviwe({
    required this.userId,
    required this.rating,
    required this.feedback,
    required this.category,
  });
}
