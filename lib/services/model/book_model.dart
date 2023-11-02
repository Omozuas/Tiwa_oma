import 'package:Tiwa_Oma/services/model/review_model.dart';
import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:Tiwa_Oma/services/model/user_model.dart';

class BookinModel {
  final id;
  final appointmentDate;
  final hairImg;
  final hairName;
  final appointmentTime;
  final amount;
  final showStatus;
  final bookingCount;
  final UserModel userId;
  final StylistModel stylistId;
  final transactionId;
  final ReviewModel ratingId;

  BookinModel({
    required this.id,
    required this.appointmentDate,
    required this.hairImg,
    required this.hairName,
    required this.appointmentTime,
    required this.amount,
    required this.bookingCount,
    required this.showStatus,
    required this.userId,
    required this.stylistId,
    required this.transactionId,
    required this.ratingId,
  });
}

class BookinModel2 {
  final appointmentDate;
  final hairImg;
  final hairName;
  final appointmentTime;
  final amount;
  final showStatus;
  final bookingCount;
  final UserModel userId;
  final stylistId;
  final transactionId;
  final ratingId;
  final id;

  BookinModel2({
    required this.id,
    required this.appointmentDate,
    required this.hairImg,
    required this.hairName,
    required this.appointmentTime,
    required this.amount,
    required this.bookingCount,
    required this.showStatus,
    required this.userId,
    required this.stylistId,
    required this.transactionId,
    required this.ratingId,
  });
}

class StylistBookinModel {
  num bookingCount;
  late final averageRating;
  final StylistModel stylistId;

  StylistBookinModel(
      {required this.bookingCount,
      required this.stylistId,
      required this.averageRating});
}

class ClientBookinModel {
  num bookingCount;

  final UserModel clientId;

  ClientBookinModel({
    required this.bookingCount,
    required this.clientId,
  });
}
