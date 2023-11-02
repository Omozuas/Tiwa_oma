import 'package:Tiwa_Oma/admin/adminBooking.dart';
import 'package:Tiwa_Oma/admin/adminCostormers.dart';
import 'package:Tiwa_Oma/admin/adminStylist.dart';
import 'package:Tiwa_Oma/admin/components/adminUserDetailsCard_Item.dart';
import 'package:Tiwa_Oma/admin/components/drawer_list_title.dart';
import 'package:Tiwa_Oma/admin/components/dreawer.dart';
import 'package:Tiwa_Oma/admin/controllers/responsive.dart';
import 'package:Tiwa_Oma/services/adminApi.dart';
import 'package:Tiwa_Oma/services/bookApi.dart';
import 'package:Tiwa_Oma/services/model/admin_model.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/services/updateApi.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key, this.token});
  final token;
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String email = '';
  String username = '';
  String profileImg = '';
  String clientNum = '';
  String stylistNum = '';
  String totalNumOfBooking = '';
  late final id;
  late String fcmToken = '';
  late SharedPreferences prefsDevice;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminRecords();
    getAllBooking();
    getAllBookingMadeAndCount();
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

  List<StylistBookinModel> stylists = [];
  Future<void> getAllBookingMadeAndCount() async {
    final res = await BookingApi.fetchAllBookingMadeWithAndCount(widget.token);
    setState(() {
      stylists = res;
    });
  }

  Future<void> getAdminRecords() async {
    await AdminApi.fetchAllDataRecords(widget.token).then((value) {
      setState(() {
        totalNumOfBooking = value.totalBooking.toString();

        clientNum = value.uniqueUserIds.toString();

        stylistNum = value.uniqueStylistIds.toString();
      });
    });

    print(totalNumOfBooking);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    color: Colors.white,
                    color2: Colors.white,
                    color3: GlobalColors.yellow,
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
                    color: Colors.black,
                    color2: GlobalColors.darkshadeblack,
                    color3: GlobalColors.white,
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
                scrollDirection: Axis.vertical,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Dashboard",
                                style: TextStyle(
                                    color: GlobalColors.lightblack,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Card(
                                    child: Container(
                                      width: 260,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "No of Customers",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: GlobalColors.gray3),
                                              ),
                                              Text(
                                                "${clientNum}",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500,
                                                    color: GlobalColors
                                                        .darkshadeblack),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 40,
                                              ),
                                              FaIcon(
                                                Icons.people_outline_outlined,
                                                color: GlobalColors.yellow,
                                                size: 40,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: Container(
                                      width: 260,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Bookings",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: GlobalColors.gray3),
                                              ),
                                              Text(
                                                "${totalNumOfBooking}",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500,
                                                    color: GlobalColors
                                                        .darkshadeblack),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 40,
                                              ),
                                              FaIcon(
                                                FontAwesomeIcons.book,
                                                color: GlobalColors.yellow,
                                                size: 40,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: Container(
                                      width: 260,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Stylist",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: GlobalColors.gray3),
                                              ),
                                              Text(
                                                "${stylistNum}",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500,
                                                    color: GlobalColors
                                                        .darkshadeblack),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 40,
                                              ),
                                              FaIcon(
                                                FontAwesomeIcons.scissors,
                                                color: GlobalColors.yellow,
                                                size: 40,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Bookings",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: GlobalColors
                                                          .darkshadeblack,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              DataTable(
                                                  columnSpacing: 100,
                                                  columns: [
                                                    DataColumn(
                                                      label: Text(
                                                        "Client",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Text(
                                                        "Braids",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Text(
                                                        "Stylist",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Text(
                                                        "Amount",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Text(
                                                        "Date",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                        label: Text(
                                                      "Status",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ))
                                                  ],
                                                  rows: number1
                                                      .map(
                                                          (data) => DataRow(
                                                                  cells: [
                                                                    DataCell(Text(
                                                                        '${data.userId.username}')),
                                                                    DataCell(Text(
                                                                        '${data.hairName}')),
                                                                    DataCell(Text(
                                                                        '${data.stylistId.username}')),
                                                                    DataCell(Text(
                                                                        '${data.amount}')),
                                                                    DataCell(Text(
                                                                        '${data.appointmentDate}')),
                                                                    if (data.showStatus ==
                                                                        'paid')
                                                                      DataCell(
                                                                        Container(
                                                                          width:
                                                                              45,
                                                                          height:
                                                                              22,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                136,
                                                                                236,
                                                                                139),
                                                                            borderRadius:
                                                                                BorderRadius.vertical(top: Radius.circular(100), bottom: Radius.circular(100)),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              "${data.showStatus}",
                                                                              style: TextStyle(color: Color.fromARGB(255, 27, 120, 30), fontSize: 13),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    if (data.showStatus ==
                                                                        "Pending")
                                                                      DataCell(
                                                                        Container(
                                                                          width:
                                                                              45,
                                                                          height:
                                                                              22,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                237,
                                                                                164,
                                                                                164),
                                                                            borderRadius:
                                                                                BorderRadius.vertical(top: Radius.circular(100), bottom: Radius.circular(100)),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              "${data.showStatus}",
                                                                              style: TextStyle(color: Color.fromARGB(255, 129, 29, 29), fontSize: 10),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                  ]))
                                                      .toList()),
                                            ]),
                                      )
                                    ],
                                  )),
                                  SizedBox(
                                    width: 385,
                                    child: Row(
                                      children: [
                                        Column(
                                          children: stylists
                                              .map((e) => Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Stylist",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: GlobalColors
                                                                    .darkshadeblack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  e.stylistId.profileImg ==
                                                                          null
                                                                      ? Container(
                                                                          width:
                                                                              50,
                                                                          height:
                                                                              50,

                                                                          // padding: EdgeInsets.all(0),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            // shape: BoxShape.circle,
                                                                            borderRadius:
                                                                                BorderRadius.circular(54),
                                                                            image:
                                                                                DecorationImage(
                                                                              image: AssetImage(
                                                                                "assets/images/rectangle-1041.jpg",
                                                                              ),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          width:
                                                                              50,
                                                                          height:
                                                                              50,

                                                                          // padding: EdgeInsets.all(0),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            // shape: BoxShape.circle,
                                                                            borderRadius:
                                                                                BorderRadius.circular(54),
                                                                            image:
                                                                                DecorationImage(
                                                                              image: NetworkImage(
                                                                                "${e.stylistId.profileImg}",
                                                                              ),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Text(
                                                                            "${e.stylistId.username}"),
                                                                        SizedBox(
                                                                          width:
                                                                              120,
                                                                        ),
                                                                        Text(
                                                                            "${e.bookingCount} Appointment"),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                        "${e.stylistId.email}"),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
              ))
        ],
      )),
    );
  }
}
