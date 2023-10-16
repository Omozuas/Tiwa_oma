import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:Tiwa_Oma/services/model/user_model.dart';

class NotificationModel {
  final StylistModel stylistModel;
  final UserModel userModel;
  final bookingDate;
  final bookingTime;
  final bookingId;

  NotificationModel({
    required this.stylistModel,
    required this.userModel,
    required this.bookingDate,
    required this.bookingTime,
    required this.bookingId,
  });
}
