import 'dart:io';

import 'package:Tiwa_Oma/services/model/review_model.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class Stylistservices {
  void StylistId({
    required Stylistddetailinfo,
    required String hairstylname,
    required amount,
    required Stylistreviwe,
    required List<File> hairImage,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('ddxaoh6po', 'dkxovy0z');
      List<String> images = [];
      for (int i = 0; i < hairImage.length; i++) {
        CloudinaryResponse resp = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(hairImage[i].path, folder: hairstylname));
        images.add(resp.secureUrl);
      }
    } catch (e) {}
  }
}

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
