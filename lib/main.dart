// import 'package:flutter/foundation.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
import 'package:Tiwa_Oma/client/views/payWithCardPin.dart';
import 'package:Tiwa_Oma/stylist/StylistDashboard.dart';
import 'package:Tiwa_Oma/view/Signuo.view.dart';
import 'package:Tiwa_Oma/view/Signup2.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
// import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
// import 'package:Tiwa_Oma/stylist/StylistDashboard.dart';
// import 'package:Tiwa_Oma/view/Login.view.dart';
// import 'package:Tiwa_Oma/view/Signuo.view.dart';
// import 'package:Tiwa_Oma/providers/user_provider.dart';
// import 'package:Tiwa_Oma/view/Splash.view.dart';
// import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
// import 'package:Tiwa_Oma/stylist/StylistDashboard.dart';
// import 'package:provider/provider.dart';

// import 'client/views/seeStylistLocation.view.dart';
// import 'Nave_Bar/main_page.dart';
// import 'package:Tiwa_Oma/Nave_Bar/main_page.dart';
// import 'package:Tiwa_Oma/view/Bookings.view.dart';
// import 'package:Tiwa_Oma/view/dashboard.view.dart';
// import 'package:Tiwa_Oma/components/order_tracking_page.dart';
// import 'package:Tiwa_Oma/view/BookedSuccess.view.dart';
// import 'package:Tiwa_Oma/view/seeStylistLocation.view.dart';
// import 'package:Tiwa_Oma/view/TransactionReview.dart';
// import 'package:Tiwa_Oma/view/PayWithCard.dart';
// import 'package:Tiwa_Oma/view/TransactionReview.view.dart';
// import 'package:Tiwa_Oma/view/Splash.view.dart';
// import 'package:Tiwa_Oma/view/payMentMethod.view.dart';
// import 'package:Tiwa_Oma/view/Splash.view.dart';
// import 'package:Tiwa_Oma/view/Splash.view.dart';
// import 'package:Tiwa_Oma/view/stylist.view.dart';
// import 'package:Tiwa_Oma/view/stylistReviews.view.dart';
// import 'package:Tiwa_Oma/view/stylistReviews.view.dart';
// import 'package:Tiwa_Oma/view/LoginAndSignup.view.dart';
// import 'package:Tiwa_Oma/view/dashboard.view.dart';
// import 'package:Tiwa_Oma/view/Splash.view.dart';
// import 'package:Tiwa_Oma/view/dashboard.view.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tiwa Oma',
      debugShowCheckedModeBanner: false,
      home: StylistDashboard(),
    );
  }
}
