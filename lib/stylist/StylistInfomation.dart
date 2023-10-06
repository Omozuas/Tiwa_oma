import 'package:Tiwa_Oma/services/model/review_model.dart';
import 'package:Tiwa_Oma/services/model/vendo_Model.dart';
import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/services/providers/reviewApi.dart';
import 'package:Tiwa_Oma/services/providers/vendorApi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/stylist/AllAppointment.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:Tiwa_Oma/stylist/stylistProfile.dart';
import 'package:Tiwa_Oma/stylist/uploadPhotos.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import '../utils/global.colors.dart';
import '../widgets/ItemListAndCard.weidget.dart';
import '../widgets/PhotoListAndCard.widget.dart';
import 'StylistDashboard.dart';

class StylistInfomation extends StatefulWidget {
  const StylistInfomation({super.key, this.token, this.photodetails});
  final token;
  final photodetails;
  @override
  State<StylistInfomation> createState() => _StylistInfomationState();
}

class _StylistInfomationState extends State<StylistInfomation>
    with AutomaticKeepAliveClientMixin<StylistInfomation> {
  String email = '';
  late final token;
  String username = '';
  String profileImg = '';
  late final id;
  List<ReviewModel> user = [];
  List<VendorModel> vendorStylist = [];
  @override
  bool get wantKeepAlive => true; // Set to true to keep the state alive

  // Track the selected tab
  final bool _showItemList = true;

  int _currentSelection = 1;
  double _selectorPositionX = 9;
  final double _selectorWidth = 200.0;
//need key
  final double profileHeiht = 120;
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();

  _selectedItem(int id) {
    _currentSelection = id;

    ///set up key
    GlobalKey selectedGlobalKey = GlobalKey();
    switch (id) {
      case 1:
        selectedGlobalKey = _key1;
        break;
      case 2:
        selectedGlobalKey = _key2;
        break;

      default:
    }
    //need function
    _setWidgetPositionx(selectedGlobalKey);
    setState(() {});
  }

//positin center
  _setWidgetPositionx(GlobalKey selectedKey) {
    final RenderBox widgetRederBox =
        selectedKey.currentContext!.findRenderObject() as RenderBox;

    final widgetPosition = widgetRederBox.localToGlobal(Offset.zero);
    final widgetSize = widgetRederBox.size;

    _selectorPositionX =
        widgetPosition.dx - ((_selectorWidth - widgetSize.width) / 2);
    // need variables
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    try {
      id = jwtDecodedToken['id'];
      getuserById(id);
      fetchUserData(id);
      fetchVendorData(id);
      // print(id);
      // print(jwtDecodedToken['email']);
      // print(widget.token);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _setWidgetPositionx(_key1));
  }

  Future<void> fetchUserData(id) async {
    final response = await ReviewApi.fetchUserData(widget.token, id);
    setState(() {
      user = response;
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

  Future<void> fetchVendorData(id) async {
    final response = await VendorApi.fetchVendorData(widget.token, id);
    setState(() {
      vendorStylist = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Stylist Information"),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: Column(children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: profileImg.isEmpty
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: GlobalColors.yellow,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: GlobalColors.blue,
                                        width: 3,
                                      ),
                                    ),
                                    width: 120,
                                    height: 120,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                          "assets/images/memoji-boys-5231.png",
                                        )),
                                  )
                                : Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: GlobalColors.blue,
                                        width: 3,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: profileHeiht / 2,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          NetworkImage("${profileImg}"),
                                    )),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: GlobalColors.green,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: FaIcon(FontAwesomeIcons.pencil,
                                      size: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "${username}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadPhotos(
                                token: widget.token,
                              )));
                },
                splashColor: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 140,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: GlobalColors.green,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.image,
                          color: GlobalColors.green,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Add Photo",
                          style: TextStyle(
                              color: GlobalColors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, bottom: 13, right: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                key: _key1,
                                onTap: () => _selectedItem(1),
                                child: Text(
                                  "My Reviews",
                                  style: TextStyle(
                                      color: _currentSelection == 1
                                          ? GlobalColors.yellow
                                          : GlobalColors.gray,
                                      fontSize: 18,
                                      fontWeight: _currentSelection == 1
                                          ? FontWeight.w500
                                          : FontWeight.w400),
                                ),
                              ),
                              const SizedBox(
                                width: 104,
                              ),
                              InkWell(
                                key: _key2,
                                onTap: () => _selectedItem(2),
                                child: Text(
                                  "Photos",
                                  style: TextStyle(
                                      color: _currentSelection == 2
                                          ? GlobalColors.yellow
                                          : GlobalColors.gray,
                                      fontSize: 18,
                                      fontWeight: _currentSelection == 2
                                          ? FontWeight.w500
                                          : FontWeight.w400),
                                ),
                              ),
                            ]),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.fastOutSlowIn,
                        left: _selectorPositionX,
                        bottom: 2,
                        child: Container(
                          width: 99.0,
                          height: 3,
                          decoration: ShapeDecoration(
                              shape: const StadiumBorder(),
                              color: GlobalColors.yellow),
                        ),
                      ),
                    ],
                  ),
                  // need model
                ],
              ),
              if (_showItemList) // Conditionally render the ItemList
                Column(children: [
                  const SizedBox(
                    height: 15,
                  ),
                  ItemListStateful(
                    user: user
                        .where(
                          (element) => element.category == _currentSelection,
                        )
                        .toList(),
                  ),
                ]),
              PhotoList(
                vendorStylist: vendorStylist
                    .where(
                      (element) => element.category == _currentSelection,
                    )
                    .toList(),
                token: widget.token,
                onTap: null,
              ),
            ]),
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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistDashboard(
                                    token: widget.token,
                                  )));
                    },
                    icon: const FaIcon(
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
                  Text(
                    'client',
                    style: TextStyle(color: GlobalColors.darkshadeblack),
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
                              builder: (context) => StylistProfile(
                                    token: widget.token,
                                  )));
                    },
                    icon: Icon(
                      Ionicons.person_outline,
                      size: 30,
                      color: GlobalColors.yellow,
                    ),
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(color: GlobalColors.yellow),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
