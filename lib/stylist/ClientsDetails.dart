import 'package:Tiwa_Oma/services/bookApi.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/stylist/stylistProfile.dart';
import 'package:Tiwa_Oma/stylist/widgets/clientsInfoItemAndCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/client/views/Profile.view.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import '../utils/global.colors.dart';
import 'AllAppointment.dart';
import 'StylistDashboard.dart';

class ClientsDetails extends StatefulWidget {
  const ClientsDetails({super.key, this.token, this.userId});
  final token;
  final userId;

  @override
  State<ClientsDetails> createState() => _ClientsDetailsState();
}

class _ClientsDetailsState extends State<ClientsDetails> {
  List<BookinModel2> userBooking = [];
  @override
  void initState() {
    super.initState();
    fetchBookingDataIdDetails(widget.userId);
    print(widget.token);
    print('userId:${widget.userId}');
  }

  Future<void> fetchBookingDataIdDetails(id) async {
    final respons =
        await BookingApi.fetchBookingDataIdDetails(widget.token, id);

    setState(() {
      userBooking = respons;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Clients"),
        elevation: 0,
        backgroundColor: GlobalColors.white,
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
          await fetchBookingDataIdDetails(widget.userId);
        },
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ClientInfoItem(
                token: widget.token,
                userBooking: userBooking,
              )
              //  Column(
              //   children: [
              //     Center(
              //       child: Column(
              //         children: [
              //           Container(
              //             width: 119,
              //             height: 119,

              //             // padding: EdgeInsets.all(0),
              //             decoration: BoxDecoration(
              //               // shape: BoxShape.circle,
              //               borderRadius: BorderRadius.circular(54),
              //               image: const DecorationImage(
              //                 image: AssetImage("assets/images/rectangle-1047.png"),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //           const SizedBox(
              //             height: 20,
              //           ),
              //           Text(
              //             "Grace A",
              //             style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w600,
              //                 color: GlobalColors.darkshadeblack),
              //           )
              //         ],
              //       ),
              //     ),
              //     Column(
              //       children: [
              //         SizedBox(
              //           width: size.width,
              //           height: 407,
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Center(
              //               child: Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                   children: [
              //                     Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Text("Name",
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.shadeblack)),
              //                         Text("Grace. A ",
              //                             style: TextStyle(
              //                                 fontSize: 20,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.darkshadeblack)),
              //                       ],
              //                     ),
              //                     Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Text("Address",
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.shadeblack)),
              //                         Text("23, Osborne ikoyi lagos State ",
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.darkshadeblack)),
              //                       ],
              //                     ),
              //                     Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Text("Country",
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.shadeblack)),
              //                         Text("Nigeria",
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.darkshadeblack)),
              //                       ],
              //                     ),
              //                     Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Text("Phone Number",
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.shadeblack)),
              //                         Text("08102918566 ",
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.darkshadeblack)),
              //                       ],
              //                     ),
              //                     Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Text("Email Address",
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.shadeblack)),
              //                         Text("Example@gmail.com",
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.darkshadeblack)),
              //                       ],
              //                     ),
              //                     Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Text("No of Appointment",
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.shadeblack)),
              //                         Text("12",
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: GlobalColors.darkshadeblack)),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     const SizedBox(
              //       height: 55,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 10,
              //       ),
              //       child: Container(
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 20),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             children: [
              //               ElevatedButton(
              //                 onPressed: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) => Clients(
              //                               token: widget.token,
              //                             )),
              //                   );
              //                 },
              //                 style: ElevatedButton.styleFrom(
              //                     backgroundColor: Colors.black,
              //                     shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(29.0),
              //                     ),
              //                     minimumSize: const Size(370, 49)),
              //                 child: const Text(
              //                   "Return",
              //                   style: TextStyle(
              //                       fontSize: 16, fontWeight: FontWeight.w600),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),

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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistDashboard(
                                    token: widget.token,
                                  )));
                    },
                    child: const FaIcon(
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllAppointment(
                                    token: widget.token,
                                  )));
                    },
                    child: const FaIcon(
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Clients(
                                    token: widget.token,
                                  )));
                    },
                    child: Icon(
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistProfile(
                                    token: widget.token,
                                  )));
                    },
                    child: const Icon(Ionicons.person_outline, size: 30),
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
