import 'package:Tiwa_Oma/services/api.dart';
import 'package:Tiwa_Oma/services/model/review_model.dart';
import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:Tiwa_Oma/services/model/stylist_services.dart';
import 'package:Tiwa_Oma/services/model/vendo_Model.dart';
import 'package:Tiwa_Oma/services/providers/reviewApi.dart';
import 'package:Tiwa_Oma/services/providers/vendorApi.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:Tiwa_Oma/widgets/stylistItemListDetailAndItemCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:Tiwa_Oma/client/views/payMentMethod.view.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/client/views/Profile.view.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../widgets/AddButtonListAndCard.widget.dart';
import '../../widgets/ItemListAndCard.weidget.dart';
import '../../widgets/RatingTextFeld.dart';
import '../../widgets/TimePickerWidget.dart';
import '../../widgets/addButtons.widgets.dart';
import '../../widgets/datePickeWidget.dart';
import '../../widgets/photos.widget.dart';
import 'Bookings.view.dart';

class stylistReview extends StatefulWidget {
  final token;
  var photodetails;
  var bookingTym;
  var bookingdate;
  StylistModel stylistModel;

  stylistReview(
      {super.key,
      required this.token,
      this.photodetails,
      this.bookingTym,
      this.bookingdate,
      required this.stylistModel});

  @override
  State<stylistReview> createState() => _stylistReviewState();
}

class _stylistReviewState extends State<stylistReview>
    with AutomaticKeepAliveClientMixin<stylistReview> {
  //for getting reviews
  List<ReviewModel> user = [];
  List<VendorModel> vendorStylist = [];

  late String email;
  late final token;
  late String username;
  late final id;

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
  late final Photos photodetails1;
  final double coverHight = 240;
  final double profileHeiht = 120;
  num _currentSelection = 1;
  int _currentSelection2 = 2;
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
    super.initState();

    if (widget.token.isEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      fetchUserData();
      fetchVendorData();
      print(widget.stylistModel.address);
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _setWidgetPositionx(_key1));

      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      try {
        email = jwtDecodedToken['email'];
        token = jwtDecodedToken['token'];
        username = jwtDecodedToken['username'];
        id = jwtDecodedToken['id'];
        // print(id);
        // print(jwtDecodedToken['email']);
        // print(widget.token);
      } catch (e) {
        // Handle token decoding errors here, e.g., log the error or show an error message.
        print('Error decoding token: $e');
      }
    }
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

  // Track whether the Pixcard is selected
  bool isSelected = false;
  void CheckOption(index) {
    setState(() {
      isSelected = index;
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
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchUserData();
          await fetchVendorData();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                StylistItemdetails(
                  vendorStylist: vendorStylist,
                  token: widget.token,
                ),
                SizedBox(
                  height: 150,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 7, bottom: 13, right: 7),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                      Column(
                        children: [
                          AddButtonList(
                            categoryButton: buttonAdd
                                .where((element) =>
                                    element.category == _currentSelection)
                                .toList(),
                            reviewAdded:
                                _reviewAdded, // Pass the _reviewAdded state
                            addReview:
                                _addReview, // Pass the _addReview function
                          ),
                          ItemListStateful(
                            user: user
                                .where(
                                  (element) =>
                                      element.category == _currentSelection,
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
                                        onPressed: () {
                                          _addReview();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(29.0),
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
                    if (_currentSelection == 2)
                      Column(
                        children: [
                          if (_currentSelection == 2)
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: vendorStylist.length,
                                itemBuilder: (
                                  context,
                                  index,
                                ) {
                                  final pix = vendorStylist[index];

                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              widget.photodetails = {
                                                'hairName': pix.hairStlye,
                                                "amount": pix.hartPrice,
                                                "hairImg": pix.hairStyleImg,
                                              };

                                              print(widget.photodetails);
                                              // Toggle the selected state
                                            },
                                            child: Column(
                                              children: [
                                                Card(
                                                  elevation:
                                                      isSelected ? 0.9 : 0.8,
                                                  color: isSelected
                                                      ? GlobalColors.yellow
                                                      : null,
                                                  child: pix
                                                          .hairStyleImg.isEmpty
                                                      ? Container(
                                                          width: 172,
                                                          height: 129,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(
                                                                'assets/images/cartoon.png',
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 172,
                                                          height: 129,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  NetworkImage(
                                                                '${pix.hairStyleImg}',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      pix.hairStlye,
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? GlobalColors
                                                                .yellow
                                                            : Colors.grey,
                                                        fontSize: isSelected
                                                            ? 14
                                                            : 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .currency_pound_outlined,
                                                      color: isSelected
                                                          ? GlobalColors.yellow
                                                          : Colors.black,
                                                    ),
                                                    Text(
                                                      '${pix.hartPrice}',
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? GlobalColors
                                                                .yellow
                                                            : Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
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
                                        onPressed: () {
                                          if (_currentSelection == 2) {
                                            _selectedItem(3);
                                          }
                                          print(widget.photodetails);
                                          print(widget.token);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(29.0),
                                            ),
                                            minimumSize: const Size(379, 50)),
                                        child: const Text(
                                          "Proceed",
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
                      token: widget.token,
                      id: id,
                      stylistModel: widget.stylistModel,
                    ),
                    Column(
                      children: [
                        if (_currentSelection == 3)
                          // Check if "Date/Time" tab is selected
                          Wrap(
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
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DateTimePickerWidget(
                                      photodetails: widget.photodetails,
                                      focusDay: _focusDay,
                                      format: _format,
                                      currentDay: _curretDay,
                                      onFormatChanged: (format) {
                                        setState(() {
                                          _format = format;
                                        });
                                      },
                                      onDaySelected: (selectedDay, focusedDay) {
                                        final formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(selectedDay);
                                        widget.bookingdate = {
                                          "appointmentDate": "$formattedDate"
                                        };
                                        print(
                                            'Selected Day: ${widget.bookingdate}');
                                        setState(() {
                                          _curretDay = selectedDay;
                                          _focusDay = focusedDay;
                                          _dateSelected = true;

                                          if (selectedDay.weekday == 6 ||
                                              selectedDay.weekday == 7) {
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
                                      photodetsils: widget.photodetails,
                                      isWeekend: _isWeekend,
                                      currentIndex4: _currentIndex4,
                                      onTimeSelected: (index) {
                                        setState(() {
                                          _currentIndex4 = index;
                                        });
                                        widget.bookingTym = {
                                          "appointmentime":
                                              "${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}"
                                        };
                                        print(widget.bookingTym);
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  // print(widget.photodetails);
                                                  // print(widget.bookingTym);
                                                  // print(widget.bookingdate);
                                                  // print(widget.stylistModel.id);
                                                  // print(id);
                                                  if (widget.bookingdate ==
                                                      null) {
                                                    print("is empty");
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Card(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          height: 80,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    226,
                                                                    19,
                                                                    43),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .error_outline_sharp,
                                                                color: Colors
                                                                    .white,
                                                                size: 40,
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Expanded(
                                                                  child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'failed',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                      'Pleas select a Date',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .white,
                                                                      ))
                                                                ],
                                                              ))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ));
                                                  } else if (widget
                                                          .bookingTym ==
                                                      null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Card(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          height: 80,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    226,
                                                                    19,
                                                                    43),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .error_outline_sharp,
                                                                color: Colors
                                                                    .white,
                                                                size: 40,
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Expanded(
                                                                  child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'failed',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                      'Pleas select a Time',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .white,
                                                                      ))
                                                                ],
                                                              ))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ));
                                                  } else if (widget
                                                          .photodetails ==
                                                      null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Card(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          height: 80,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    226,
                                                                    19,
                                                                    43),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .error_outline_sharp,
                                                                color: Colors
                                                                    .white,
                                                                size: 40,
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Expanded(
                                                                  child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'failed',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                      'select an HairStyle you are intrested in',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .white,
                                                                      ))
                                                                ],
                                                              ))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ));
                                                  } else {
                                                    var booking = {
                                                      'stylistId':
                                                          "${widget.stylistModel.id}",
                                                      "userId": "${id}",
                                                      ...widget.photodetails,
                                                      ...widget.bookingTym,
                                                      ...widget.bookingdate,
                                                      "ratingId": "${id}"
                                                    };
                                                    var notify = {
                                                      'stylistId':
                                                          "${widget.stylistModel.id}",
                                                    };
                                                    print(widget
                                                        .stylistModel.username);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    payMenthod(
                                                                      token: widget
                                                                          .token,
                                                                      bookDetails:
                                                                          booking,
                                                                      booknotify:
                                                                          notify,
                                                                      booknotifystylistName: widget
                                                                          .stylistModel
                                                                          .username,
                                                                    )));
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              29.0),
                                                    ),
                                                    minimumSize:
                                                        const Size(370, 49)),
                                                child: const Text(
                                                  "Book Appointment",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ],
                          )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        color: GlobalColors.white,
        child: SizedBox(
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
                              builder: (context) => Dashboard(
                                    token: widget.token,
                                  )));
                    },
                    child: Icon(
                      LineIcons.home,
                      size: 30,
                    ),
                  ),
                  Text(
                    'Home',
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
                              builder: (context) => Bookings(
                                    token: widget.token,
                                  )));
                    },
                    child: const Icon(
                      LineIcons.book,
                      size: 30,
                    ),
                  ),
                  const Text('Bookings'),
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
                              builder: (context) => Stylist(
                                    token: widget.token,
                                  )));
                    },
                    child: Icon(
                      Ionicons.cut_outline,
                      size: 30,
                      color: GlobalColors.yellow,
                    ),
                  ),
                  Text('stylist', style: TextStyle(color: GlobalColors.yellow)),
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
                              builder: (context) => MyProfile(
                                    token: widget.token,
                                  )));
                    },
                    child: const Icon(
                      Ionicons.person_outline,
                      size: 30,
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

  Future<void> fetchUserData() async {
    final response =
        await ReviewApi.fetchUserData(widget.token, widget.stylistModel.id);
    setState(() {
      user = response;
    });
  }

  Future<void> fetchVendorData() async {
    final response =
        await VendorApi.fetchVendorData(widget.token, widget.stylistModel.id);
    setState(() {
      vendorStylist = response;
    });
  }
}

class DropReview extends StatefulWidget {
  DropReview(
      {super.key,
      required this.reviewAdded,
      required this.currentSelection,
      required this.sendReview,
      required this.addReviewRating,
      required this.stylistModel,
      this.token,
      this.id});
  final bool reviewAdded;
  final num currentSelection;
  late final token;
  final bool sendReview;
  late final id;
  StylistModel stylistModel;
  final void Function() addReviewRating;

  @override
  State<DropReview> createState() => _DropReviewState();
}

class _DropReviewState extends State<DropReview> {
  late String email;

  TextEditingController RatingController = TextEditingController();

  bool _isNotValidate = false;

  @override
  Widget build(BuildContext context) {
    double ratingValue = 0.0; // Initialize the rating value
    return Column(
      children: [
        if (widget.currentSelection == 1 && widget.reviewAdded)
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
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          itemBuilder: (context, _) => Icon(
                                Icons.star_border_outlined,
                                color: GlobalColors.yellow,
                                size: 60,
                              ),
                          onRatingUpdate: (rating) {
                            ratingValue = rating;
                            // print(rating);
                          })
                    ],
                  ),
                ),
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
                              print(widget.id);
                              widget.addReviewRating();
                              print(RatingController.text);
                              print(ratingValue);
                              if (RatingController.text.isNotEmpty) {
                                var sendReviewBody = {
                                  'rating': ratingValue,
                                  'feedback': RatingController.text,
                                  'category': 1,
                                  'userId': widget.id,
                                  'stylistId': widget.stylistModel.id
                                };
                                Api.reviewgApp(sendReviewBody)
                                    .then((response) async {
                                  print(response.message);

                                  print(response.data);
                                  print(response.success);
                                  if (response.success == true) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Container(
                                        padding: const EdgeInsets.all(8),
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: GlobalColors.green,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'success',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(response.message,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            ))
                                          ],
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    ));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => stylistReview(
                                                  token: widget.token,
                                                  stylistModel:
                                                      widget.stylistModel,
                                                )));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Card(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          height: 80,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 226, 19, 43),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.error_outline_sharp,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'failed',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(response.message,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                      ))
                                                ],
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    ));
                                  }
                                });
                              } else {
                                _isNotValidate = true;
                              }
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

  _errorMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 80,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 227, 163, 170),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.error_outline_sharp,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'failed',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Text('bfbfbfbbb',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ))
                ],
              ))
            ],
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}
