import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:flutter/material.dart';

import 'package:Tiwa_Oma/client/views/Profile.view.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
import 'package:Tiwa_Oma/client/views/payWithTransfar.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

import 'Bookings.view.dart';
import 'PayWithCard.dart';

class payMenthod extends StatefulWidget {
  payMenthod(
      {super.key,
      required this.token,
      this.bookDetails,
      this.booknotify,
      this.booknotifystylistName});
  final token;
  final bookDetails;
  final booknotify;
  final booknotifystylistName;
  @override
  State<payMenthod> createState() => _payMenthodState();
}

class _payMenthodState extends State<payMenthod> {
  int _type = 1;
  String email = '';
  late final token1;
  String username = '';
  String number = '';
  late final id;
  void _handleRadion(Object? e) => setState(() {
        _type = e as int;
      });

  @override
  void initState() {
    super.initState();
    print(widget.token);
    print(widget.bookDetails);

    try {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      print(widget.token);
      email = jwtDecodedToken['email'];
      print(email);
      // username = jwtDecodedToken['username'];
      // number = jwtDecodedToken['number'];
      // id = jwtDecodedToken['id'];
      print(jwtDecodedToken['id']);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Payment Method"),
        elevation: 0,
        backgroundColor: Colors.transparent,
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
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              width: size.width,
              height: 55,
              decoration: BoxDecoration(
                border: _type == 1
                    ? Border.all(width: 1, color: Colors.yellow)
                    : Border.all(width: 0.3, color: Colors.black87),
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/mingcute-transfer-line.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 23,
                          ),
                          Text(
                            "Pay with Transfer",
                            style: _type == 1
                                ? const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)
                                : const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                          ),
                        ],
                      ),
                      Radio(
                        value: 1,
                        groupValue: _type,
                        onChanged: _handleRadion,
                        activeColor: Colors.yellow.shade500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: size.width,
              height: 55,
              decoration: BoxDecoration(
                border: _type == 2
                    ? Border.all(width: 1, color: Colors.yellow)
                    : Border.all(width: 0.3, color: Colors.black87),
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/ion-card.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 23,
                          ),
                          Text(
                            "Pay with Card",
                            style: _type == 2
                                ? const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)
                                : const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                          ),
                        ],
                      ),
                      Radio(
                        value: 2,
                        groupValue: _type,
                        onChanged: _handleRadion,
                        activeColor: Colors.yellow.shade500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 400,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_type == 1) {
                            // Navigate to the screen for "Pay with Transfer"
                            // Replace "PayWithTransferScreen" with the actual screen class
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const payWithTranfar()),
                            );
                          } else if (_type == 2) {
                            // Navigate to the screen for "Pay with Card"
                            // Replace "PayWithCardScreen" with the actual screen class
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => payWithCard(
                                        token: widget.token,
                                        bookingDetails: widget.bookDetails,
                                        booknotify: widget.booknotify,
                                        stylistname:
                                            widget.booknotifystylistName,
                                      )),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29.0),
                            ),
                            minimumSize: const Size(370, 49)),
                        child: const Text(
                          "Proceed",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      )),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        color: GlobalColors.white,
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dashboard(
                                    token: widget.token,
                                  )));
                    },
                    child: Icon(
                      LineIcons.home,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bookings(
                                    token: widget.token,
                                  )));
                    },
                    child: const Icon(
                      LineIcons.book,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Stylist(
                                    token: widget.token,
                                  )));
                    },
                    child: Icon(
                      Ionicons.cut_outline,
                      size: 30,
                      color: GlobalColors.yellow,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyProfile(
                                    token: widget.token,
                                  )));
                    },
                    child: const Icon(
                      Ionicons.person_outline,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
