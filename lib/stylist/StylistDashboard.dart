import 'package:Tiwa_Oma/services/bookApi.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/stylist/ClientsDetails.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/stylist/AllAppointment.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:Tiwa_Oma/stylist/stylistProfile.dart';
import 'package:Tiwa_Oma/stylist/widgets/LatestAppointmentListAndCard.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

class StylistDashboard extends StatefulWidget {
  const StylistDashboard({
    super.key,
    required this.token,
  });
  final token;
  @override
  State<StylistDashboard> createState() => _StylistDashboardState();
}

class _StylistDashboardState extends State<StylistDashboard> {
  List<BookinModel> userBooking = [];
  List<BookinModel2> userBooking2 = [];
  String email = '';
  String username = '';
  String profileImg = '';
  late final id;
  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    try {
      id = jwtDecodedToken['id'];
      fetchBookingDataId(id);
      fetchBookingDataIdFrequentUserId(id);
      getuserById(id);
      print(jwtDecodedToken['email']);
      print(widget.token);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
  }

  Future<void> fetchBookingDataId(id) async {
    final respons = await BookingApi.fetchBookingDataId(widget.token, id);

    setState(() {
      userBooking = respons;
    });
  }

  Future<void> fetchBookingDataIdFrequentUserId(id) async {
    final respons =
        await BookingApi.fetchBookingDataIdFrequentUserId(widget.token, id);

    setState(() {
      userBooking2 = respons;
    });
  }

  Future<void> getuserById(id) async {
    GetUsers.fetchStylistData(widget.token, id).then((res) {
      setState(() {
        email = res.data['email'];
        username = res.data['username'];
        profileImg = res.data['profileImg'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return MyProfile();
                          // }));
                        },
                        child: profileImg.isEmpty
                            ? Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/ellipse-117.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage('${profileImg}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome Back',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            // 'Alex Samuel',
                            username,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.notifications_outlined,
                          size: 35,
                        ),
                      ),
                      const SizedBox(width: 0.1),
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          color: const Color(0XFFFF2F08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: 372,
                      // height: 119,
                      padding: const EdgeInsets.all(
                          20.0), // Add padding to the container
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        // Use a Column to stack the text elements vertically
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: GlobalColors.green,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: FaIcon(FontAwesomeIcons.info,
                                      size: 20, color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ), // Add some spacing
                              const Expanded(
                                // Expand to fill available space
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      "Discover Amazing Braids",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Text(
                                  "Complete your profile set up to have full access to the system",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .start, // Align button to the right
                            children: [
                              const SizedBox(width: 29),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: GlobalColors.yellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 1,
                                  minimumSize: const Size(0, 30),
                                ),
                                child: const Text('Start Now'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Frequent Clients',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: userBooking2.length,
                    itemBuilder: (
                      context1,
                      index1,
                    ) {
                      final bookingdata = userBooking2[index1];
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                print(bookingdata.userId.username);
                                print(bookingdata.userId.id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClientsDetails(
                                              token: widget.token,
                                              userId: bookingdata.userId.id,
                                            )));
                              },
                              child: Container(
                                width: 82,
                                height:
                                    82, // Adjust the size of the image container
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(82),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/portrait-of-young-woman-smiling-isolated.png"),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                                height:
                                    8), // Adjust the spacing between image and text
                            Text(
                              bookingdata.userId.username,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Latest Appointment',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SingleChildScrollView(
              child: AppointmentList(
                userBooking: userBooking,
              ),
            )
          ],
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
                    icon: FaIcon(
                      LineIcons.home,
                      size: 30,
                      color: GlobalColors.yellow,
                    ),
                  ),
                  Text(
                    'Home',
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
