import 'package:Tiwa_Oma/services/bookApi.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/stylist/stylistProfile.dart';
import 'package:Tiwa_Oma/stylist/widgets/ClientListAndCard.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

import 'AllAppointment.dart';
import 'StylistDashboard.dart';

class Clients extends StatefulWidget {
  const Clients({super.key, required this.token});
  final token;
  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  List<BookinModel2> userBooking = [];
  late String email;
  late String username;
  late final id;
  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    try {
      email = jwtDecodedToken['email'];
      username = jwtDecodedToken['username'];
      id = jwtDecodedToken['id'];
      fetchBookingDataIdUserId(id);
      print(jwtDecodedToken['email']);
      print(widget.token);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
  }

  Future<void> fetchBookingDataIdUserId(id) async {
    final respons = await BookingApi.fetchBookingDataIdUserId(widget.token, id);

    setState(() {
      userBooking = respons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Clients"),
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
      body: ClientstList(
        userBooking: userBooking,
        token: widget.token,
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
                              builder: (context) => AllAppointment(
                                    token: widget.token,
                                  )));
                    },
                    icon: const FaIcon(
                      LineIcons.book,
                      size: 30,
                    ),
                  ),
                  const Text('Appointment'),
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
                              builder: (context) => Clients(
                                    token: widget.token,
                                  )));
                    },
                    icon: Icon(
                      Ionicons.people_outline,
                      size: 32,
                      color: GlobalColors.yellow,
                    ),
                  ),
                  Text(
                    'client',
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
                                  StylistProfile(token: widget.token)));
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
