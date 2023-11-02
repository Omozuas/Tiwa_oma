import 'package:Tiwa_Oma/services/bookApi.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import '../../utils/global.colors.dart';
import 'Profile.view.dart';
import 'dashboard.view.dart';

class Bookings extends StatefulWidget {
  Bookings({
    super.key,
    required this.token,
  });
  final token;

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  late final id;

  List<BookinModel> bookings2 = [];
  @override
  void initState() {
    super.initState();
    if (widget.token.isEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

      try {
        id = jwtDecodedToken['id'];
        fetchBookingData(id);
        print(jwtDecodedToken['email'] + id);
      } catch (e) {
        // Handle token decoding errors here, e.g., log the error or show an error message.
        print('Error decoding token: $e');
      }
    }
  }

  Future<void> fetchBookingData(id) async {
    final respons = await BookingApi.fetchBookingData(widget.token, id);

    setState(() {
      bookings2 = respons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Bookings"),
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
      body: SingleChildScrollView(child: BookingList(bookings2: bookings2)),
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
                    icon: Icon(
                      LineIcons.book,
                      size: 30,
                      color: GlobalColors.yellow,
                    ),
                  ),
                  Text(
                    'Bookings',
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
                              builder: (context) => Stylist(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
                      Ionicons.cut_outline,
                      size: 30,
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

class BookingList extends StatelessWidget {
  BookingList({required this.bookings2, super.key});

  List<BookinModel> bookings2 = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bookings2
          .map((e) => BookingCard(
                bookinModel: e,
              ))
          .toList(),
    );
  }
}

class BookingCard extends StatelessWidget {
  BookingCard({
    super.key,
    required this.bookinModel,
  });

  final BookinModel bookinModel;

  @override
  Widget build(BuildContext context) {
    // final date = DateFormat('yyyy-MM-dd').format(bookinModel.appointmentDate);
    return Column(
      children: [
        Container(
          child: Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
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
                          bookinModel.hairImg.isEmpty
                              ? Container(
                                  width: 70,
                                  height: 70,

                                  // padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/rectangle-1047.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 70,
                                  height: 70,

                                  // padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${bookinModel.hairImg}',
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
                                '${bookinModel.hairName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 110,
                              ),
                              Text(
                                bookinModel.appointmentDate,
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
                                    '${bookinModel.appointmentTime}',
                                    // maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: GlobalColors.lightblack,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  bookinModel.ratingId.rating == null
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: GlobalColors.yellow,
                                              size: 17,
                                            ),
                                            Text(
                                              '0',
                                              // maxLines: 1,
                                              style: const TextStyle(
                                                  // overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: GlobalColors.yellow,
                                              size: 17,
                                            ),
                                            Text(
                                              '${bookinModel.ratingId.rating}',
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
                                    width: 120,
                                  ),
                                  const Icon(
                                    Icons.currency_pound_outlined,
                                    size: 17,
                                  ),
                                  Text(
                                    '${bookinModel.amount}',
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
