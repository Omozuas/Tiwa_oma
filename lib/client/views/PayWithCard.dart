import 'package:Tiwa_Oma/client/views/payWithCardPin.dart';
import 'package:Tiwa_Oma/services/Api_service.dart';
import 'package:Tiwa_Oma/services/api.dart';
import 'package:Tiwa_Oma/services/pushNotificationApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';

import 'package:Tiwa_Oma/client/views/Profile.view.dart';

// import 'package:Tiwa_Oma/view/TransactionReview.view.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:Tiwa_Oma/widgets/FormCardText.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bookings.view.dart';
import 'TransactionReview.dart';
import 'dashboard.view.dart';

class payWithCard extends StatefulWidget {
  const payWithCard(
      {super.key,
      this.token,
      this.bookingDetails,
      this.booknotify,
      this.stylistname});
  final token;
  final bookingDetails;
  final booknotify;
  final stylistname;
  @override
  State<payWithCard> createState() => _payWithCardState();
}

class _payWithCardState extends State<payWithCard> {
  bool isChecked = false; // Initial state of the checkbox

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardExpiryMonthController = TextEditingController();
  TextEditingController cardExpiryYearController = TextEditingController();
  TextEditingController cardCVCController = TextEditingController();
  late String email = '';
  late final token;
  String? deviceToken = '';
  String username = '';
  late final number;
  late final id;
  late SharedPreferences prefsDevice;
  @override
  void initState() {
    super.initState();
    print(widget.token);
    print(widget.bookingDetails);
    initSharedPref();
    try {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      print(widget.token);
      email = jwtDecodedToken['email'];
      username = jwtDecodedToken['username'];
      number = jwtDecodedToken['number'];
      print(number);

      // id = jwtDecodedToken['id'];
      print(jwtDecodedToken['id']);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
  }

  void initSharedPref() async {
    prefsDevice = await SharedPreferences.getInstance();
    var tokend = prefsDevice.getString('deviceToken');
    setState(() {
      deviceToken = tokend;
    });
    print("device$deviceToken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pay With Card"),
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    formCardFiled(
                        label: "Card Name",
                        hintText: "Card Name",
                        keybordtype1: TextInputType.name,
                        onchange3: (value) {
                          print(value);
                        },
                        controller2: cardNameController),
                    formCardFiled(
                        label: "Card number",
                        hintText: "Card number",
                        keybordtype1: TextInputType.number,
                        inputeformat1: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(19),
                          // CardNumberInputForm(),
                        ],
                        onchange3: (value) {
                          print(value);
                        },
                        controller2: cardNumberController),
                    const SizedBox(
                      height: 0,
                    ),
                    Row(
                      children: [
                        Text('$username'),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: formCardFiled(
                              controller2: cardExpiryMonthController,
                              label: 'Expiry Month',
                              hintText: 'Expiry Month',
                              inputeformat1: [
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.digitsOnly,
                                CardMonthInputForm()
                              ],
                              keybordtype1: TextInputType.number),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: formCardFiled(
                              controller2: cardExpiryYearController,
                              label: 'Expiry Year',
                              hintText: 'Expiry Year',
                              inputeformat1: [
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.digitsOnly,
                                CardMonthInputForm()
                              ],
                              keybordtype1: TextInputType.number),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: formCardFiled(
                              controller2: cardCVCController,
                              label: 'CVV',
                              hintText: 'CVV',
                              inputeformat1: [
                                LengthLimitingTextInputFormatter(4),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keybordtype1: TextInputType.number),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              child: Checkbox(
                                checkColor: GlobalColors.textColor1,
                                hoverColor: GlobalColors.yellow,
                                value: isChecked,
                                activeColor: Colors.yellow.shade700,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked =
                                        value ?? false; // Update the state
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            Text(
                              isChecked ? 'Saved Card' : 'Save card',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 230,
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
                            print(cardNumberController.text);
                            print(cardExpiryMonthController.text);
                            print(cardExpiryYearController.text);
                            print(cardCVCController.text);

                            var cardAndBookingDetails = {
                              "card_Name": cardNameController.text,
                              "card_Number": cardNumberController.text,
                              "card_ExpMonth": cardExpiryMonthController.text,
                              "card_ExpYear": cardExpiryYearController.text,
                              "card_CVC": cardCVCController.text,
                              ...widget.bookingDetails
                            };
                            var userNum = {"number": number};
                            print(cardAndBookingDetails);
                            print(number);

                            Api.transactionOtp(userNum).then((res) => {
                                  if (res.message == "sussess")
                                    {
                                      PushNotificationApi.pushNotificationPin(
                                          "OTP CODE",
                                          res.otp,
                                          widget.token,
                                          deviceToken),
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Row(
                                            children: [
                                              Icon(
                                                Icons.check,
                                                size: 29,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'You will get an Otp PIN',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          duration: Duration(seconds: 3),
                                        ),
                                      ),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                payWithCardPin(
                                                  pin: res.otp,
                                                  pinId: res.pin_id,
                                                  token: widget.token,
                                                  cardDetails1:
                                                      cardAndBookingDetails,
                                                  booknotify: widget.booknotify,
                                                  booknotifyStylistname:
                                                      widget.stylistname,
                                                )),
                                      )
                                    }
                                });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29.0),
                              ),
                              minimumSize: const Size(370, 49)),
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
                              builder: (context) => Dashboard(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
                      LineIcons.home,
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
                              builder: (context) => Bookings(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Stylist(
                                    token: widget.token,
                                  )));
                    },
                    icon: Icon(
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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyProfile(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
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
}
