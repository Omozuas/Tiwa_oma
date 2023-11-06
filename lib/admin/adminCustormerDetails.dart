import 'package:Tiwa_Oma/admin/adminBooking.dart';
import 'package:Tiwa_Oma/admin/adminDashboard.dart';
import 'package:Tiwa_Oma/admin/adminStylist.dart';
import 'package:Tiwa_Oma/admin/components/drawer_list_title.dart';
import 'package:Tiwa_Oma/admin/controllers/responsive.dart';
import 'package:Tiwa_Oma/services/bookApi.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AdminCustormersDetails extends StatefulWidget {
  const AdminCustormersDetails({super.key, this.token, this.userID});
  final token;
  final userID;
  @override
  State<AdminCustormersDetails> createState() => _AdminCustormersDetailsState();
}

class _AdminCustormersDetailsState extends State<AdminCustormersDetails> {
  String email = '';
  String username = '';
  String? profileImg = '';
  late final id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    try {
      id = jwtDecodedToken['id'];

      getuserById(id);
      fetchBookingDataIdDetails(widget.userID);

      print(widget.userID);

      print(widget.token);
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

  List<BookinModel2> userBooking = [];
  Future<void> fetchBookingDataIdDetails(userId) async {
    final respons =
        await BookingApi.fetchBookingDataIdDetails(widget.token, widget.userID);

    setState(() {
      userBooking = respons;
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
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Customer Info",
                                style: TextStyle(
                                    color: GlobalColors.lightblack,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              !Responsive.isMobile(context)
                                  ? Row(
                                      children: userBooking
                                          .map((data) => Card(
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                      30.0),
                                                  width: 1104,
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            data.userId.profileImg ==
                                                                    null
                                                                ? Center(
                                                                    child:
                                                                        Container(
                                                                      width: 93,
                                                                      height:
                                                                          93,

                                                                      // padding: EdgeInsets.all(0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        // shape: BoxShape.circle,
                                                                        borderRadius:
                                                                            BorderRadius.circular(54),
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage(
                                                                            "assets/images/rectangle-1041.jpg",
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Center(
                                                                    child:
                                                                        Container(
                                                                      width: 93,
                                                                      height:
                                                                          93,

                                                                      // padding: EdgeInsets.all(0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        // shape: BoxShape.circle,
                                                                        borderRadius:
                                                                            BorderRadius.circular(54),
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage(
                                                                            "${data.userId.profileImg}",
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "${data.userId.username}",
                                                              style: TextStyle(
                                                                  color: GlobalColors
                                                                      .darkshadeblack,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "${data.userId.email}",
                                                              style: TextStyle(
                                                                  color: GlobalColors
                                                                      .darkshadeblack,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            DeactivatUser());
                                                                print(data
                                                                    .userId.id);
                                                              },
                                                              child: Container(
                                                                width: 83,
                                                                height: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          243,
                                                                          33,
                                                                          33)),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius: BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              5),
                                                                      bottom: Radius
                                                                          .circular(
                                                                              5)),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Deactivate",
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            227,
                                                                            27,
                                                                            27),
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Divider(
                                                          thickness: 1244,
                                                          color:
                                                              GlobalColors.gray,
                                                          height: 222,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      "Name",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.username}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Email Address",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.email}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Phone Number",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.number}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Gender",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.gender}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      "Country",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.country}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Address",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.address}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Total No of bookings",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.bookingCount}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          .toList())
                                  : Column(
                                      children: userBooking
                                          .map((data) => Card(
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  width: 1104,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            data.userId.profileImg ==
                                                                    null
                                                                ? Center(
                                                                    child:
                                                                        Container(
                                                                      width: 93,
                                                                      height:
                                                                          93,

                                                                      // padding: EdgeInsets.all(0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        // shape: BoxShape.circle,
                                                                        borderRadius:
                                                                            BorderRadius.circular(54),
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage(
                                                                            "assets/images/rectangle-1041.jpg",
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Center(
                                                                    child:
                                                                        Container(
                                                                      width: 93,
                                                                      height:
                                                                          93,

                                                                      // padding: EdgeInsets.all(0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        // shape: BoxShape.circle,
                                                                        borderRadius:
                                                                            BorderRadius.circular(54),
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage(
                                                                            "${data.userId.profileImg}",
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "${data.userId.username}",
                                                              style: TextStyle(
                                                                  color: GlobalColors
                                                                      .darkshadeblack,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "${data.userId.email}",
                                                              style: TextStyle(
                                                                  color: GlobalColors
                                                                      .darkshadeblack,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            DeactivatUser());
                                                                print(data
                                                                    .userId.id);
                                                              },
                                                              child: Container(
                                                                width: 83,
                                                                height: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          243,
                                                                          33,
                                                                          33)),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius: BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              5),
                                                                      bottom: Radius
                                                                          .circular(
                                                                              5)),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Deactivate",
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            227,
                                                                            27,
                                                                            27),
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Divider(
                                                          thickness: 1,
                                                          color:
                                                              GlobalColors.gray,
                                                          height: 2,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      "Name",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.username}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Email Address",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.email}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Phone Number",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.number}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Gender",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.gender}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      "Country",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.country}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Address",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.userId.address}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Total No of bookings",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              GlobalColors.gray3),
                                                                    ),
                                                                    Text(
                                                                      "${data.bookingCount}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              GlobalColors.gray),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          .toList())
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

  final AdminCustormersDetails widget;

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

class DeactivatUser extends StatelessWidget {
  const DeactivatUser({super.key});

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
                "Deactivate Customer",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Are you sure you want to deactivate this Customer because this can’t be undone",
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
