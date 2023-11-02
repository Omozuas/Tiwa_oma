import 'package:Tiwa_Oma/admin/adminCostormers.dart';
import 'package:Tiwa_Oma/admin/adminDashboard.dart';
import 'package:Tiwa_Oma/admin/adminStylist.dart';
import 'package:Tiwa_Oma/admin/components/drawer_list_title.dart';
import 'package:Tiwa_Oma/admin/controllers/responsive.dart';
import 'package:Tiwa_Oma/services/bookApi.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/services/updateApi.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminBooking extends StatefulWidget {
  const AdminBooking({super.key, this.token});
  final token;
  @override
  State<AdminBooking> createState() => _AdminBookingState();
}

class _AdminBookingState extends State<AdminBooking> {
  String email = '';
  String username = '';
  String profileImg = '';
  late final id;
  late String fcmToken = '';
  late SharedPreferences prefsDevice;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllBooking();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    try {
      id = jwtDecodedToken['id'];

      getuserById(id);

      print(jwtDecodedToken['email']);

      print(widget.token);
      print("see $fcmToken");
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
  }

  Future<void> getuserById(id) async {
    GetUsers.fetchStylistData(widget.token, id).then((res) {
      // if (res.data['firebaseToken'] == null) {
      //   initSharedPref();
      // } else {
      //   print(res.data['firebaseToken']);
      // }

      setState(() {
        email = res.data['email'];
        username = res.data['username'];
        profileImg = res.data['profileImg'];
      });
      print(username);
    });
  }

  Future<void> initSharedPref() async {
    prefsDevice = await SharedPreferences.getInstance();
    var tokend = prefsDevice.getString('deviceToken');
    print("device$tokend");

    updateDeviceToken(tokend, widget.token, id);
  }

  Future<void> updateDeviceToken(tokend, token, id) async {
    await UpdateuserInfoApi.updateUserDeviceToken(tokend, token, id)
        .then((value) {
      if (value.status == true) {
        print("success: ${value.message}");
      }
    });
  }

  List<BookinModel> number1 = [];
  Future<void> getAllBooking() async {
    final res = await BookingApi.fetchAllBookingData(widget.token);
    setState(() {
      number1 = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDeskTop(context))
            Expanded(
              child: Drawer(
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 40,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/image-3.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  DreawerList(
                    title: "Dashboard",
                    svgSrc: Icons.dashboard,
                    tap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AdminDashboard(
                          token: widget.token,
                        );
                      }));
                    },
                    color: Colors.black,
                    color3: GlobalColors.white,
                    color2: GlobalColors.darkshadeblack,
                  ),
                  DreawerList(
                    title: "Bookings",
                    svgSrc: FontAwesomeIcons.book,
                    tap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AdminBooking(
                          token: widget.token,
                        );
                      }));
                    },
                    color: Colors.white,
                    color2: Colors.white,
                    color3: GlobalColors.yellow,
                  ),
                  DreawerList(
                    title: "Customers",
                    svgSrc: Icons.people_outline_outlined,
                    tap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AdminCustormers(
                          token: widget.token,
                        );
                      }));
                    },
                    color: Colors.black,
                    color3: GlobalColors.white,
                    color2: GlobalColors.darkshadeblack,
                  ),
                  DreawerList(
                    title: "Stylist",
                    svgSrc: Icons.people_outline_outlined,
                    tap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AdminStylist(
                          token: widget.token,
                        );
                      }));
                    },
                    color: Colors.black,
                    color2: GlobalColors.darkshadeblack,
                    color3: GlobalColors.white,
                  ),
                  DreawerList(
                    title: "Logout",
                    svgSrc: Icons.logout_outlined,
                    tap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    color: Colors.black,
                    color2: GlobalColors.darkshadeblack,
                    color3: GlobalColors.white,
                  ),
                ]),
              ),
            ),
          Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 405,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: GlobalColors.gray2,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Search here......',
                                              hintStyle: TextStyle(
                                                  color:
                                                      GlobalColors.lightblack,
                                                  fontSize: 12),
                                              fillColor: GlobalColors.gray2,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)))),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.search,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Stack(
                                  children: [
                                    Icon(
                                      Icons.notifications_none_rounded,
                                      size: 30,
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                          color: const Color(0XFFFF2F08),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.purple.shade300,
                                ),
                                child: Center(
                                    child: Text(
                                  "A",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("$username"),
                              SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: GlobalColors.gray2,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Bookings",
                                  style: TextStyle(
                                      color: GlobalColors.lightblack,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 90,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: GlobalColors.yellow,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10),
                                          bottom: Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          FaIcon(
                                            Icons.filter_alt_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Filter",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  child: DataTable(
                                      columnSpacing: 170,
                                      columns: [
                                        DataColumn(
                                          label: Text(
                                            "Client",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            "Braids",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            "Stylist",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            "Amount",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            "Date",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        DataColumn(
                                            label: Text(
                                          "Status",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ))
                                      ],
                                      rows: number1
                                          .map((data) => DataRow(cells: [
                                                DataCell(Text(
                                                    '${data.userId.username}')),
                                                DataCell(
                                                    Text('${data.hairName}')),
                                                DataCell(Text(
                                                    '${data.stylistId.username}')),
                                                DataCell(
                                                    Text('${data.amount}')),
                                                DataCell(Text(
                                                    '${data.appointmentDate}')),
                                                if (data.showStatus == 'paid')
                                                  DataCell(
                                                    Container(
                                                      width: 45,
                                                      height: 22,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 136, 236, 139),
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        100),
                                                                bottom: Radius
                                                                    .circular(
                                                                        100)),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "${data.showStatus}",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      27,
                                                                      120,
                                                                      30),
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (data.showStatus ==
                                                    "Pending")
                                                  DataCell(
                                                    Container(
                                                      width: 45,
                                                      height: 22,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 237, 164, 164),
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        100),
                                                                bottom: Radius
                                                                    .circular(
                                                                        100)),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "${data.showStatus}",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      129,
                                                                      29,
                                                                      29),
                                                              fontSize: 10),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ]))
                                          .toList()),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
