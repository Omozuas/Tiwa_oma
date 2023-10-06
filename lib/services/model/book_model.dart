import 'package:Tiwa_Oma/services/model/review_model.dart';
import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:Tiwa_Oma/services/model/user_model.dart';

class BookinModel {
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

  BookinModel2({
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
