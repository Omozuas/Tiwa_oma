import 'package:flutter/material.dart';

import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
import 'package:Tiwa_Oma/client/views/seeStylistLocation.view.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

import 'package:lottie/lottie.dart';

import '../../utils/global.colors.dart';
import 'Bookings.view.dart';
import 'Profile.view.dart';

class BookinSuccess extends StatefulWidget {
  const BookinSuccess({super.key, this.token});
  final token;
  @override
  State<BookinSuccess> createState() => _BookinSuccessState();
}

class _BookinSuccessState extends State<BookinSuccess> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("your token ${widget.token}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Lottie.asset("assets/animation/data.json"),
            const SizedBox(height: 10),
            Text('Booking Success',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: GlobalColors.darkshadeblack)),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Your booking is successful',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 160,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeLocationOfStylist(
                                      token: widget.token,
                                    )),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29.0),
                            ),
                            minimumSize: const Size(370, 49)),
                        child: const Text(
                          "Stylist Location",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
