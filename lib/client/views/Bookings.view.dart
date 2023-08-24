import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';

import '../../utils/global.colors.dart';
import '../../widgets/BookingsViewsList.dart';
import 'Profile.view.dart';
import 'dashboard.view.dart';

class Bookings extends StatefulWidget {
  const Bookings({
    super.key,
  });

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bookings"),
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
      body:
          SingleChildScrollView(child: BookingList(bookingReview: bookingList)),
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
                              builder: (context) => const Dashboard(
                                    token: '',
                                  )));
                    },
                    icon: const Icon(
                      Icons.home_filled,
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
                              builder: (context) => const Bookings()));
                    },
                    icon: const Icon(
                      Icons.book_outlined,
                      size: 32,
                      color: Colors.yellow,
                    ),
                  ),
                  const Text(
                    'Bookings',
                    style: TextStyle(color: Colors.yellow),
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
                              builder: (context) => const Stylist()));
                    },
                    icon: const Icon(
                      Icons.style,
                      size: 32,
                    ),
                  ),
                  const Text('stylist'),
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
                    icon: const Icon(
                      Icons.person_2_outlined,
                      size: 32,
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

class BookingList extends StatelessWidget {
  const BookingList({required this.bookingReview, super.key});
  final List<Bookingii> bookingReview;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: bookingReview.map((e) => BookingCard(bookings1: e)).toList(),
    );
  }
}

class BookingCard extends StatelessWidget {
  const BookingCard({required this.bookings1, super.key});
  final Bookingii bookings1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 70,
                            height: 70,

                            // padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              image: DecorationImage(
                                image: AssetImage(
                                  bookings1.imgurl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 0,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                bookings1.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              Text(
                                bookings1.date,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: GlobalColors.lightblack),
                              ),
                              const SizedBox(
                                width: 0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    bookings1.time,
                                    // maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: GlobalColors.lightblack,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: GlobalColors.yellow,
                                        size: 17,
                                      ),
                                      Text(
                                        bookings1.rating,
                                        // maxLines: 1,
                                        style: const TextStyle(
                                            // overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 130,
                                  ),
                                  Icon(
                                    Icons.currency_pound_outlined,
                                    size: 17,
                                  ),
                                  Text(
                                    bookings1.amount,
                                    // maxLines: 1,
                                    style: TextStyle(
                                        // overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w600,
                                        color: GlobalColors.darkshadeblack,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
