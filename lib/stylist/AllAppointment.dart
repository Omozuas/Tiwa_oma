import 'package:Tiwa_Oma/services/bookApi.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/stylist/stylistProfile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:Tiwa_Oma/stylist/widgets/PreviousDaysAppointmentInfo.dart';
import 'package:Tiwa_Oma/stylist/widgets/PreviousDaysAppointmentListAndCard.dart';
import 'package:Tiwa_Oma/stylist/widgets/TodaysAppointentList.dart';
import 'package:Tiwa_Oma/stylist/widgets/TodaysAppointmentListAndCard.dart';
import 'package:Tiwa_Oma/stylist/widgets/YestadayAppoinmentInnfo.dart';
import 'package:Tiwa_Oma/stylist/widgets/YestadayAppointmentCardAndList.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import '../utils/global.colors.dart';
import 'StylistDashboard.dart';

class AllAppointment extends StatefulWidget {
  const AllAppointment({super.key, required this.token});
  final token;
  @override
  State<AllAppointment> createState() => _AllAppointmentState();
}

class _AllAppointmentState extends State<AllAppointment> {
  String email = '';
  late final token;
  String username = '';
  late final id;
  String profileImg = '';
  @override
  void initState() {
    super.initState();
    print(widget.token);
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    id = jwtDecodedToken['id'];
    try {
      email = jwtDecodedToken['email'];
      token = jwtDecodedToken['token'];
      fetchBookingDataIdToday(token, id);

      print(id);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
  }

  List<BookinModel> today = [];
  Future<void> fetchBookingDataIdToday(token, stylistId) async {
    var res = await BookingApi.fetchBookingDataIdToday(widget.token, stylistId);
    setState(() {
      today = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("All Appointment"),
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
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Today ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: GlobalColors.darkshadeblack),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TodayAppointmentList(
                todayappoimentReview: today,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Yesterday ${DateTime.now().subtract(Duration(days: 1)).day}/${DateTime.now().subtract(Duration(days: 1)).month}/${DateTime.now().subtract(Duration(days: 1)).year}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: GlobalColors.darkshadeblack),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              YestadayAppointmentList(
                yestadayappoimentReview: yestadayappointmentList1,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${DateTime.now().subtract(Duration(days: 2)).day}/${DateTime.now().subtract(Duration(days: 2)).month}/${DateTime.now().subtract(Duration(days: 2)).year}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: GlobalColors.darkshadeblack),
                  ),
                ],
              ),
              const SizedBox(
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
                              builder: (context) => StylistDashboard(
                                    token: widget.token,
                                  )));
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
                              builder: (context) =>
                                  AllAppointment(token: widget.token)));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Clients(token: widget.token)));
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
                              builder: (context) => StylistProfile(
                                    token: widget.token,
                                  )));
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
