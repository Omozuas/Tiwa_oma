import 'package:Tiwa_Oma/services/bookApi.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/widgets/transactionItemandCard.dart';
import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
// import 'package:Tiwa_Oma/view/seeStylistLocation.view.dart';

import 'BookedSuccess.view.dart';
import 'Bookings.view.dart';
import 'Profile.view.dart';
import 'stylist.view.dart';

class transactionReview extends StatefulWidget {
  const transactionReview({super.key, this.token, this.bookingId});
  final token;
  final bookingId;

  @override
  State<transactionReview> createState() => _transactionReviewState();
}

class _transactionReviewState extends State<transactionReview> {
  late String email;
  late final token;
  late String username;
  List<BookinModel> transactionDetails = [];
  @override
  void initState() {
    super.initState();
    getBokingById();
    print(widget.bookingId);
    print("your token ${widget.token}");
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    try {
      email = jwtDecodedToken['email'];
      token = jwtDecodedToken['token'];
      username = jwtDecodedToken['username'];
      print(jwtDecodedToken['email']);
      print(widget.token);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
  }

  Future<void> getBokingById() async {
    final res =
        await BookingApi.fetchBookingById(widget.token, widget.bookingId);
    setState(() {
      transactionDetails = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.bakgrounddeemwhite,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Transaction Review"),
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
                height: 20,
              ),
              TransactionList(transactionReview: transactionDetails),
              const SizedBox(
                height: 100,
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
                                  builder: (context) => BookinSuccess(
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
                            "Proceed",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 8,
        child: SizedBox(
          height: 69,
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
                              builder: (context) => Dashboard(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
                      LineIcons.home,
                      size: 32,
                    ),
                  ),
                  const Text(
                    'Home',
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
                              builder: (context) => Bookings(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
                      LineIcons.book,
                      size: 30,
                    ),
                  ),
                  const Text('Bookings'),
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
                              builder: (context) => Stylist(
                                    token: widget.token,
                                  )));
                    },
                    icon: Icon(
                      Ionicons.cut_outline,
                      size: 30,
                      color: GlobalColors.yellow,
                    ),
                  ),
                  Text('stylist', style: TextStyle(color: GlobalColors.yellow)),
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
                              builder: (context) => MyProfile(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
                      Ionicons.person_outline,
                      size: 30,
                    ),
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
