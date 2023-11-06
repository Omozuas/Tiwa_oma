import 'package:Tiwa_Oma/admin/adminBooking.dart';
import 'package:Tiwa_Oma/admin/adminCostormers.dart';
import 'package:Tiwa_Oma/admin/adminDashboard.dart';
import 'package:Tiwa_Oma/admin/components/drawer_list_title.dart';
import 'package:Tiwa_Oma/admin/controllers/responsive.dart';
import 'package:Tiwa_Oma/services/bookApi.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class AdminStylist extends StatefulWidget {
  const AdminStylist({super.key, this.token});
  final token;
  @override
  State<AdminStylist> createState() => _AdminStylistState();
}

class _AdminStylistState extends State<AdminStylist> {
  String email = '';
  String username = '';
  String? profileImg = '';
  String clientNum = '';
  String stylistNum = '';
  String totalNumOfBooking = '';
  late final id;
  late String fcmToken = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

  List<StylistBookinModel> stylists = [];
  Future<void> getAllBookingMadeAndCount() async {
    final res = await BookingApi.fetchAllBookingMadeWithAndCount(widget.token);
    setState(() {
      stylists = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawer = GlobalKey();
    return Scaffold(
      key: _drawer,
      backgroundColor: Colors.white,
      drawer: SizedBox(
        width: 150,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " Stylist",
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
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: !Responsive.isMobile(context)
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Card(
                                          child: DataTable(
                                              columnSpacing: 100,
                                              columns: [
                                                DataColumn(
                                                  label: Text(
                                                    "Name",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    "Email",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    "No of Appointment",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    "Rating",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                              rows: stylists
                                                  .map(
                                                      (data) => DataRow(cells: [
                                                            DataCell(Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                data.stylistId
                                                                            .profileImg ==
                                                                        null
                                                                    ? Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              40,
                                                                          height:
                                                                              40,

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
                                                                        ),
                                                                      )
                                                                    : Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              40,
                                                                          height:
                                                                              40,

                                                                          // padding: EdgeInsets.all(0),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            // shape: BoxShape.circle,
                                                                            borderRadius:
                                                                                BorderRadius.circular(54),
                                                                            image:
                                                                                DecorationImage(
                                                                              image: NetworkImage(
                                                                                "${data.stylistId.profileImg}",
                                                                              ),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                    '${data.stylistId.username}'),
                                                              ],
                                                            )),
                                                            DataCell(Text(
                                                                '${data.stylistId.email}')),
                                                            data.bookingCount
                                                                    .isNull
                                                                ? DataCell(Text(
                                                                    '0',
                                                                    style: TextStyle(
                                                                        color: GlobalColors
                                                                            .green),
                                                                  ))
                                                                : DataCell(Text(
                                                                    '${data.bookingCount.toString()}',
                                                                    style: TextStyle(
                                                                        color: GlobalColors
                                                                            .green),
                                                                  )),
                                                            data.averageRating ==
                                                                    null
                                                                ? DataCell(
                                                                    SmoothStarRating(
                                                                    borderColor:
                                                                        GlobalColors
                                                                            .gray3,
                                                                    allowHalfRating:
                                                                        true,
                                                                    spacing:
                                                                        0.0,
                                                                    starCount:
                                                                        5,
                                                                    rating: 0,
                                                                    color: GlobalColors
                                                                        .yellow,
                                                                    size: 18,
                                                                  ))
                                                                : DataCell(
                                                                    SmoothStarRating(
                                                                    borderColor:
                                                                        GlobalColors
                                                                            .gray3,
                                                                    allowHalfRating:
                                                                        true,
                                                                    spacing:
                                                                        0.0,
                                                                    starCount:
                                                                        5,
                                                                    rating: data
                                                                            .averageRating
                                                                        as double,
                                                                    color: GlobalColors
                                                                        .yellow,
                                                                    size: 18,
                                                                  )),
                                                            DataCell(
                                                              InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              DeactivatStylist());
                                                                  print(data
                                                                      .stylistId
                                                                      .id);
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 83,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .red),
                                                                    borderRadius: BorderRadius.vertical(
                                                                        top: Radius.circular(
                                                                            100),
                                                                        bottom:
                                                                            Radius.circular(100)),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Dactivate",
                                                                      style: TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              129,
                                                                              29,
                                                                              29),
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ]))
                                                  .toList()),
                                        )
                                      ],
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Card(
                                          child: DataTable(
                                              columnSpacing: 120,
                                              columns: [
                                                DataColumn(
                                                  label: Text(
                                                    "Name",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    "Email",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    "No of Appointment",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    "Rating",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                              rows: stylists
                                                  .map(
                                                      (data) => DataRow(cells: [
                                                            DataCell(Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                data.stylistId
                                                                            .profileImg ==
                                                                        null
                                                                    ? Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              40,
                                                                          height:
                                                                              40,

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
                                                                        ),
                                                                      )
                                                                    : Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              40,
                                                                          height:
                                                                              40,

                                                                          // padding: EdgeInsets.all(0),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            // shape: BoxShape.circle,
                                                                            borderRadius:
                                                                                BorderRadius.circular(54),
                                                                            image:
                                                                                DecorationImage(
                                                                              image: NetworkImage(
                                                                                "${data.stylistId.profileImg}",
                                                                              ),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                    '${data.stylistId.username}'),
                                                              ],
                                                            )),
                                                            DataCell(Text(
                                                                '${data.stylistId.email}')),
                                                            data.bookingCount
                                                                    .isNull
                                                                ? DataCell(Text(
                                                                    '0',
                                                                    style: TextStyle(
                                                                        color: GlobalColors
                                                                            .green),
                                                                  ))
                                                                : DataCell(Text(
                                                                    '${data.bookingCount.toString()}',
                                                                    style: TextStyle(
                                                                        color: GlobalColors
                                                                            .green),
                                                                  )),
                                                            data.averageRating ==
                                                                    null
                                                                ? DataCell(
                                                                    SmoothStarRating(
                                                                    borderColor:
                                                                        GlobalColors
                                                                            .gray3,
                                                                    allowHalfRating:
                                                                        true,
                                                                    spacing:
                                                                        0.0,
                                                                    starCount:
                                                                        5,
                                                                    rating: 0,
                                                                    color: GlobalColors
                                                                        .yellow,
                                                                    size: 18,
                                                                  ))
                                                                : DataCell(
                                                                    SmoothStarRating(
                                                                    borderColor:
                                                                        GlobalColors
                                                                            .gray3,
                                                                    allowHalfRating:
                                                                        true,
                                                                    spacing:
                                                                        0.0,
                                                                    starCount:
                                                                        5,
                                                                    rating: data
                                                                            .averageRating
                                                                        as double,
                                                                    color: GlobalColors
                                                                        .yellow,
                                                                    size: 18,
                                                                  )),
                                                            DataCell(
                                                              InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              DeactivatStylist());
                                                                  print(data
                                                                      .stylistId
                                                                      .id);
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 83,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .red),
                                                                    borderRadius: BorderRadius.vertical(
                                                                        top: Radius.circular(
                                                                            100),
                                                                        bottom:
                                                                            Radius.circular(100)),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Dactivate",
                                                                      style: TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              129,
                                                                              29,
                                                                              29),
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ]))
                                                  .toList()),
                                        )
                                      ],
                                    ),
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

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    super.key,
    required this.widget,
  });

  final AdminStylist widget;

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
          color3: GlobalColors.white,
          color2: GlobalColors.darkshadeblack,
        ),
        DreawerList(
          title: "Customers",
          svgSrc: Icons.people_outline_outlined,
          tap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AdminStylist(
                token: widget.token,
              );
            }));
          },
          color: Colors.white,
          color2: Colors.white,
          color3: GlobalColors.yellow,
        ),
        DreawerList(
          title: "Logout",
          svgSrc: Icons.logout_outlined,
          tap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
          color: Colors.black,
          color2: GlobalColors.darkshadeblack,
          color3: GlobalColors.white,
        ),
      ]),
    );
  }
}

class DeactivatStylist extends StatelessWidget {
  const DeactivatStylist({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 53,
                height: 53,
                child: Center(
                    child: FaIcon(
                  Icons.person,
                  color: Colors.red,
                  size: 30,
                )),
                decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(54),
                    color: Colors.red.shade100),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Deactivate Stylist",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Are you sure you want to deactivate this stylist, because this can’t be undone",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: GlobalColors.gray,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
                softWrap: true,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 83,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(5),
                            bottom: Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 83,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 243, 33, 33),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(5),
                            bottom: Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          "Deactivate",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
