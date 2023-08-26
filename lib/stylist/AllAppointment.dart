import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/client/views/Profile.view.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:Tiwa_Oma/stylist/widgets/PreviousDaysAppointmentInfo.dart';
import 'package:Tiwa_Oma/stylist/widgets/PreviousDaysAppointmentListAndCard.dart';
import 'package:Tiwa_Oma/stylist/widgets/TodaysAppointentList.dart';

import 'package:Tiwa_Oma/stylist/widgets/TodaysAppointmentListAndCard.dart';
import 'package:Tiwa_Oma/stylist/widgets/YestadayAppoinmentInnfo.dart';
import 'package:Tiwa_Oma/stylist/widgets/YestadayAppointmentCardAndList.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
// import 'package:http/http.dart';

import '../utils/global.colors.dart';
import 'StylistDashboard.dart';

class AllAppointment extends StatefulWidget {
  const AllAppointment({super.key});

  @override
  State<AllAppointment> createState() => _AllAppointmentState();
}

class _AllAppointmentState extends State<AllAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("All Appointment"),
        elevation: 0,
        backgroundColor: GlobalColors.mainColor,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: GlobalColors.darkshadeblack),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TodayAppointmentList(
                todayappoimentReview: todayappointmentList1,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Yesterday",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: GlobalColors.darkshadeblack),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              YestadayAppointmentList(
                yestadayappoimentReview: yestadayappointmentList1,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "11 Aug, 2023",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: GlobalColors.darkshadeblack),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              PriciousDaysAppointmentList(
                previousdaysappoimentReview: previousdaysappointmentList1,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StylistDashboard()));
                    },
                    icon: const FaIcon(
                      LineIcons.home,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Home',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllAppointment()));
                    },
                    icon: FaIcon(
                      LineIcons.book,
                      size: 30,
                      color: GlobalColors.yellow,
                    ),
                  ),
                  Text(
                    'Appointment',
                    style: TextStyle(color: GlobalColors.yellow),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Clients()));
                    },
                    icon: const Icon(
                      Ionicons.people_outline,
                      size: 32,
                    ),
                  ),
                  const Text('client'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyProfile()));
                    },
                    icon: const Icon(Ionicons.person_outline, size: 30),
                  ),
                  const Text('Profile'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
