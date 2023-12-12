import 'package:Tiwa_Oma/services/bookApi.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import 'Bookings.view.dart';
import 'Profile.view.dart';
import 'dashboard.view.dart';

class AllBookings extends StatefulWidget {
  const AllBookings({super.key, this.token});
  final token;
  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> {
  late String email;
  late final token;
  late String username;
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
        email = jwtDecodedToken['email'];
        token = jwtDecodedToken['token'];
        username = jwtDecodedToken['username'];
        id = jwtDecodedToken['id'];
        fetchBookingData(id);
        print(jwtDecodedToken['email'] + id);
        print(widget.token);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("All Bookings"),
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
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchBookingData(id);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 316,
                      height: 43,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.search,
                              color: GlobalColors.yellow,
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: GlobalColors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.filter_list_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BookingList(bookings2: bookings2)
              ],
            ),
          ),
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
                  Text(
                    'Home',
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
                    child: Icon(
                      LineIcons.book,
                      size: 30,
                    ),
                  ),
                  Text(
                    'Bookings',
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
                    ),
                  ),
                  Text(
                    'stylist',
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
                    child: Icon(Ionicons.person_outline,
                        size: 30, color: GlobalColors.yellow),
                  ),
                  Text('Profile', style: TextStyle(color: GlobalColors.yellow)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
