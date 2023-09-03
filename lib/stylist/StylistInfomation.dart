import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/stylist/AllAppointment.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:Tiwa_Oma/stylist/stylistProfile.dart';
import 'package:Tiwa_Oma/stylist/uploadPhotos.dart';
import 'package:Tiwa_Oma/stylist/widgets/StylistProfilePix.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import '../utils/global.colors.dart';
import '../widgets/ItemListAndCard.weidget.dart';
import '../widgets/PhotoListAndCard.widget.dart';
import '../widgets/Review.view.dart';
import '../widgets/photos.widget.dart';
import 'StylistDashboard.dart';

class StylistInfomation extends StatefulWidget {
  const StylistInfomation({super.key});

  @override
  State<StylistInfomation> createState() => _StylistInfomationState();
}

class _StylistInfomationState extends State<StylistInfomation>
    with AutomaticKeepAliveClientMixin<StylistInfomation> {
  @override
  bool get wantKeepAlive => true; // Set to true to keep the state alive

  // Track the selected tab
  bool _showItemList = true;

  int _currentSelection = 1;
  double _selectorPositionX = 9;
  final double _selectorWidth = 200.0;
//need key

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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _setWidgetPositionx(_key1));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Stylist Information"),
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
              StylistproFilePix(),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadPhotos()));
                },
                splashColor: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(10),
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
                        SizedBox(
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
              SizedBox(
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
                  SizedBox(
                    height: 15,
                  ),
                  ItemList(
                    categoryReview: reviewList
                        .where(
                          (element) => element.Category == _currentSelection,
                        )
                        .toList(),
                  ),
                ]),
              PhotoList(
                categoryPhotos: photosList
                    .where(
                      (element) => element.category2 == _currentSelection,
                    )
                    .toList(),
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
                              builder: (context) => const StylistDashboard(
                                    token: '',
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
                              builder: (context) => const AllAppointment()));
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
                              builder: (context) => const Clients()));
                    },
                    icon: Icon(
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
                              builder: (context) => const StylistProfile()));
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
