import 'package:Tiwa_Oma/services/model/stylist_model.dart';

class VendorModel {
  final StylistModel stylistModel;
  final String hairStlye;
  final category;
  final hartPrice;
  final String hairStyleImg;
  final avgRating;

  VendorModel({
    required this.stylistModel,
    required this.hairStlye,
    required this.category,
    required this.hairStyleImg,
    required this.hartPrice,
    this.avgRating,
  });
}

class ReviewModel1 {
  final String feedback;
  final rating;
  final userId;
  final category;

  ReviewModel1({
    required this.userId,
    required this.rating,
    required this.feedback,
    required this.category,
  });
}

class VendorModelImg {
  final stylistModelId;
  final hairStlye;
  final category;
  final hartPrice;
  final hairStyleImg;
  final reviewModelId;
  VendorModelImg({
    required this.stylistModelId,
    required this.hairStlye,
    required this.category,
    required this.hairStyleImg,
    required this.reviewModelId,
    required this.hartPrice,
  });
}
