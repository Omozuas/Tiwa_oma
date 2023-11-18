import 'package:Tiwa_Oma/admin/adminBooking.dart';
import 'package:Tiwa_Oma/admin/adminCustormerDetails.dart';
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

class AdminCustormers extends StatefulWidget {
  const AdminCustormers({super.key, this.token});
  final token;
  @override
  State<AdminCustormers> createState() => _AdminCustormersState();
}

class _AdminCustormersState extends State<AdminCustormers> {
  String email = '';
  String username = '';
  String? profileImg = '';
  late final id;
  late String fcmToken = '';
  late SharedPreferences prefsDevice;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    try {
      id = jwtDecodedToken['id'];

      getuserById(id);
      getAllBooking();

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

  List<ClientBookinModel> number1 = [];
  Future<void> getAllBooking() async {
    final res = await BookingApi.fetchAllBookingMadeWithCustormersAndCount(
        widget.token);
    setState(() {
      number1 = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawer = GlobalKey();
    return Scaffold(
      key: _drawer,
      backgroundColor: Colors.white,
      drawer: SizedBox(
        width: 200,
        child: NavigationDrawer(
          widget: widget,
        ),
      ),
      appBar: !Responsive.isMobile(context)
          ? PreferredSize(preferredSize: Size.zero, child: SizedBox())
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.white10,
              leading: IconButton(
                onPressed: () {
                  _drawer.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: GlobalColors.gray,
                ),
              )),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !Responsive.isMobile(context)
              ? Expanded(
                  child: NavigationDrawer(
                    widget: widget,
                  ),
                )
              : PreferredSize(preferredSize: Size.zero, child: SizedBox()),
          Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    !Responsive.isMobile(context)
                        ? Padding(
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
                                                    hintText:
                                                        'Search here......',
                                                    hintStyle: TextStyle(
                                                        color: GlobalColors
                                                            .lightblack,
                                                        fontSize: 12),
                                                    fillColor:
                                                        GlobalColors.gray2,
                                                    filled: true,
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
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
                                                    color: Colors.white,
                                                    width: 1),
                                                color: const Color(0XFFFF2F08),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
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
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
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
                                                    hintText:
                                                        'Search here......',
                                                    hintStyle: TextStyle(
                                                        color: GlobalColors
                                                            .lightblack,
                                                        fontSize: 12),
                                                    fillColor:
                                                        GlobalColors.gray2,
                                                    filled: true,
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
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
                                                    color: Colors.white,
                                                    width: 1),
                                                color: const Color(0XFFFF2F08),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Customers",
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
                                height: 20,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: !Responsive.isMobile(context)
                                    ? Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Card(
                                                child: DataTable(
                                                    columnSpacing: 160,
                                                    columns: [
                                                      DataColumn(
                                                        label: Text(
                                                          "Name",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Text(
                                                          "Phone Number",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Text(
                                                          "Email",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Text(
                                                          "Number OF Booking",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Text(
                                                          "",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                    rows: number1
                                                        .map(
                                                            (data) => DataRow(
                                                                    cells: [
                                                                      DataCell(
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          data.clientId.profileImg == null
                                                                              ? Center(
                                                                                  child: Container(
                                                                                    width: 40,
                                                                                    height: 40,

                                                                                    // padding: EdgeInsets.all(0),
                                                                                    decoration: BoxDecoration(
                                                                                      // shape: BoxShape.circle,
                                                                                      borderRadius: BorderRadius.circular(54),
                                                                                      image: DecorationImage(
                                                                                        image: AssetImage(
                                                                                          "assets/images/rectangle-1041.jpg",
                                                                                        ),
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : Center(
                                                                                  child: Container(
                                                                                    width: 40,
                                                                                    height: 40,

                                                                                    // padding: EdgeInsets.all(0),
                                                                                    decoration: BoxDecoration(
                                                                                      // shape: BoxShape.circle,
                                                                                      borderRadius: BorderRadius.circular(54),
                                                                                      image: DecorationImage(
                                                                                        image: NetworkImage(
                                                                                          "${data.clientId.profileImg}",
                                                                                        ),
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                              '${data.clientId.username}'),
                                                                        ],
                                                                      )),
                                                                      DataCell(Text(
                                                                          '${data.clientId.number}')),
                                                                      DataCell(Text(
                                                                          '${data.clientId.email}')),
                                                                      DataCell(
                                                                          Text(
                                                                        '${data.bookingCount}',
                                                                        style: TextStyle(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                27,
                                                                                120,
                                                                                30),
                                                                            fontSize:
                                                                                13),
                                                                      )),
                                                                      DataCell(
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            print(data.clientId.id);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) {
                                                                              return AdminCustormersDetails(
                                                                                token: widget.token,
                                                                                userID: data.clientId.id,
                                                                              );
                                                                            }));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                83,
                                                                            height:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(color: Colors.blue),
                                                                              borderRadius: BorderRadius.vertical(top: Radius.circular(100), bottom: Radius.circular(100)),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "Open",
                                                                                style: TextStyle(color: Color.fromARGB(255, 71, 24, 146), fontSize: 13),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]))
                                                        .toList()),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Card(
                                                child: DataTable(
                                                    columnSpacing: 50,
                                                    columns: [
                                                      DataColumn(
                                                        label: Text(
                                                          "Name",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Text(
                                                          "Phone Number",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Text(
                                                          "Email",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Text(
                                                          "Number OF Booking",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Text(
                                                          "",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                    rows: number1
                                                        .map(
                                                            (data) => DataRow(
                                                                    cells: [
                                                                      DataCell(
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          data.clientId.profileImg == null
                                                                              ? Center(
                                                                                  child: Container(
                                                                                    width: 40,
                                                                                    height: 40,

                                                                                    // padding: EdgeInsets.all(0),
                                                                                    decoration: BoxDecoration(
                                                                                      // shape: BoxShape.circle,
                                                                                      borderRadius: BorderRadius.circular(54),
                                                                                      image: DecorationImage(
                                                                                        image: AssetImage(
                                                                                          "assets/images/rectangle-1041.jpg",
                                                                                        ),
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : Center(
                                                                                  child: Container(
                                                                                    width: 40,
                                                                                    height: 40,

                                                                                    // padding: EdgeInsets.all(0),
                                                                                    decoration: BoxDecoration(
                                                                                      // shape: BoxShape.circle,
                                                                                      borderRadius: BorderRadius.circular(54),
                                                                                      image: DecorationImage(
                                                                                        image: NetworkImage(
                                                                                          "${data.clientId.profileImg}",
                                                                                        ),
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                              '${data.clientId.username}'),
                                                                        ],
                                                                      )),
                                                                      DataCell(Text(
                                                                          '${data.clientId.number}')),
                                                                      DataCell(Text(
                                                                          '${data.clientId.email}')),
                                                                      DataCell(
                                                                          Text(
                                                                        '${data.bookingCount}',
                                                                        style: TextStyle(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                27,
                                                                                120,
                                                                                30),
                                                                            fontSize:
                                                                                13),
                                                                      )),
                                                                      DataCell(
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            print(data.clientId.id);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) {
                                                                              return AdminCustormersDetails(
                                                                                token: widget.token,
                                                                                userID: data.clientId.id,
                                                                              );
                                                                            }));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                83,
                                                                            height:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(color: Colors.blue),
                                                                              borderRadius: BorderRadius.vertical(top: Radius.circular(100), bottom: Radius.circular(100)),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "Open",
                                                                                style: TextStyle(color: Color.fromARGB(255, 71, 24, 146), fontSize: 13),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]))
                                                        .toList()),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                              )
                            ]),
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

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    super.key,
    required this.widget,
  });

  final AdminCustormers widget;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DreawerList(
                title: "Dashboard",
                svgSrc: Icons.dashboard,
                tap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                tap: () {},
                color: Colors.white,
                color2: Colors.white,
                color3: GlobalColors.yellow,
              ),
              DreawerList(
                title: "Stylist",
                svgSrc: Icons.people_outline_outlined,
                tap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
            ],
          ),
        ),
      ]),
    );
  }
}
