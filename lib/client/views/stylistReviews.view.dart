// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:Tiwa_Oma/client/views/payMentMethod.view.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';
// import 'package:get/get.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';

import 'package:Tiwa_Oma/client/views/Profile.view.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../texts/BuildTopText.dart';
import '../../texts/RowTexts.dart';
import '../../texts/TextLocation.dart';
import '../../widgets/AddButtonListAndCard.widget.dart';
import '../../widgets/ItemListAndCard.weidget.dart';
import '../../widgets/PhotoListAndCard.widget.dart';
import '../../widgets/RatingTextFeld.dart';
import '../../widgets/Review.view.dart';
import '../../widgets/TimePickerWidget.dart';
import '../../widgets/addButtons.widgets.dart';
import '../../widgets/datePickeWidget.dart';
import '../../widgets/photos.widget.dart';
import 'Bookings.view.dart';

class stylistReview extends StatefulWidget {
  const stylistReview({
    super.key,
  });

  @override
  State<stylistReview> createState() => _stylistReviewState();
}

class _stylistReviewState extends State<stylistReview>
    with AutomaticKeepAliveClientMixin<stylistReview> {
  //decleration

  bool isDateTimeTabSelected = false;

  @override
  bool get wantKeepAlive => true; // Set to true to keep the state alive

  // Track the selected tab
  bool _showItemList = true;
  bool _reviewAdded = false; // Track if "Add Review" button is clicked
  bool _sendRating = false;

  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _curretDay = DateTime.now();
  int? _currentIndex4;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  final double coverHight = 240;
  final double profileHeiht = 120;
  int _currentSelection = 1;
  double _selectorPositionX = 5;
  final double _selectorWidth = 200.0;
//need key

  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();

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
      case 3:
        selectedGlobalKey = _key3;
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

  bool _isNotValidate = false;
  void _addReview() {
    setState(() {
      _reviewAdded = true;
      _showItemList = false;
      _isNotValidate = true;
      _sendRating = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Don't forget to call super.build(context)
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Stylist',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(child: buildCoverImage()),
                    Container(child: buildTop()),
                    Container(child: buildText()),
                    Container(child: rowText()),
                    Container(child: TextLocation()),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 160,
            ),
            Column(
              children: [
                rowView(),
              ],
            ),
            TimeDate(),
            Column(
              children: [
                PhotoList(
                  categoryPhotos: photosList
                      .where(
                        (element) => element.category2 == _currentSelection,
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (_currentSelection == 2)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(29.0),
                                  ),
                                  minimumSize: const Size(379, 50)),
                              child: const Text(
                                "Proceed",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            AddButtonList(
              categoryButton: buttonAdd
                  .where((element) => element.category == _currentSelection)
                  .toList(),
              reviewAdded: _reviewAdded, // Pass the _reviewAdded state
              addReview: _addReview, // Pass the _addReview function
            ),
            if (_showItemList) // Conditionally render the ItemList
              Column(
                children: [
                  ItemList(
                    categoryReview: reviewList
                        .where(
                          (element) => element.Category == _currentSelection,
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (_currentSelection == 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(29.0),
                                    ),
                                    minimumSize: const Size(379, 50)),
                                child: const Text(
                                  "Send Review",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            DropReview(
              reviewAdded: _reviewAdded,
              currentSelection: _currentSelection,
              sendReview: _sendRating,
              addReviewRating: _addReview,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 8,
        child: SizedBox(
          height: 69,
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
                              builder: (context) => const Dashboard(
                                    token: '',
                                  )));
                    },
                    icon: const Icon(
                      Icons.home_filled,
                      size: 32,
                    ),
                  ),
                  const Text(
                    'Home',
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
                              builder: (context) => const Bookings()));
                    },
                    icon: const Icon(
                      Icons.book_outlined,
                      size: 32,
                    ),
                  ),
                  const Text('Bookings'),
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
                              builder: (context) => const Stylist()));
                    },
                    icon: const Icon(
                      Icons.style,
                      size: 32,
                      color: Colors.yellow,
                    ),
                  ),
                  const Text('stylist', style: TextStyle(color: Colors.yellow)),
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
                              builder: (context) => const MyProfile()));
                    },
                    icon: const Icon(
                      Icons.person_2_outlined,
                      size: 32,
                    ),
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

  Positioned buildTop() {
    return Positioned(
      top: 180,
      child: buildProfilePix(),
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          "assets/images/rectangle-1031.png",
          height: coverHight,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfilePix() => Container(
          child: CircleAvatar(
        radius: profileHeiht / 2,
        backgroundColor: Colors.white,
        backgroundImage: const AssetImage('assets/images/rectangle-1041.jpg'),
      ));

  Widget rowView() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 7, bottom: 13, right: 7),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        key: _key1,
                        onTap: () => _selectedItem(1),
                        child: Text(
                          "Reviews",
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
                        width: 40,
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
                      const SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        key: _key3,
                        onTap: () => _selectedItem(3),
                        child: Text(
                          "Date/Time",
                          style: TextStyle(
                              color: _currentSelection == 3
                                  ? GlobalColors.yellow
                                  : GlobalColors.gray,
                              fontSize: 18,
                              fontWeight: _currentSelection == 3
                                  ? FontWeight.w500
                                  : FontWeight.w400),
                        ),
                      )
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
                      shape: const StadiumBorder(), color: GlobalColors.yellow),
                ),
              ),
            ],
          ),
          // need model
        ],
      );

  Widget TimeDate() {
    if (_currentSelection == 3) {
      // Check if "Date/Time" tab is selected
      return Wrap(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                height: 30,
              ),
              Text(
                "Date",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                width: 250,
                height: 30,
              ),
              Text(
                "Time",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            DateTimePickerWidget(
              focusDay: _focusDay,
              format: _format,
              currentDay: _curretDay,
              onFormatChanged: (format) {
                setState(() {
                  _format = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _curretDay = selectedDay;
                  _focusDay = focusedDay;
                  _dateSelected = true;

                  if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
                    _isWeekend = true;
                    _timeSelected = false;
                    _currentIndex4 = null;
                  } else {
                    _isWeekend = false;
                  }
                });
              },
            ),

            DatePickerWidget(
              isWeekend: _isWeekend,
              currentIndex4: _currentIndex4,
              onTimeSelected: (index) {
                setState(() {
                  _currentIndex4 = index;
                });
              },
            ),

            //button
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const payMenthod()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29.0),
                            ),
                            minimumSize: const Size(370, 49)),
                        child: const Text(
                          "Book Appointment",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ],
      );
    } else {
      return Container(); // Return an empty container when other tabs are selected
    }
  }
}

class DropReview extends StatelessWidget {
  DropReview(
      {super.key,
      required this.reviewAdded,
      required this.currentSelection,
      required this.sendReview,
      required this.addReviewRating});
  final bool reviewAdded;
  final int currentSelection;
  final bool sendReview;
  TextEditingController RatingController = TextEditingController();
  bool _isNotValidate = false;
  // Track if "Add Review" button is clicked
  final void Function() addReviewRating;
  void send() async {
    if (RatingController.text.isNotEmpty) {
      // var responsed = await http.post(Uri.parse(registration),
      //     headers: {"Content-Type": "application/json"},
      //     body: jsonEncode(registerBody));
      // print(responsed);
    } else {
      _isNotValidate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (currentSelection == 1 && reviewAdded)
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Whats your review',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                ratingBars(),
                const SizedBox(
                  height: 35,
                ),
                RatingFiled(
                  label: "Please share your opinion about the product ",
                  hintText: "Your Review",
                  controller2: RatingController,
                  err: _isNotValidate ? "Enter Proper info" : null,
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              addReviewRating();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(29.0),
                                ),
                                minimumSize: const Size(379, 50)),
                            child: const Text(
                              "Send Review",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget ratingBars() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => Icon(
                    Icons.star_border_outlined,
                    color: GlobalColors.yellow,
                    size: 60,
                  ),
              onRatingUpdate: (rating) {
                print(rating);
              })
        ],
      ),
    );
  }
}
