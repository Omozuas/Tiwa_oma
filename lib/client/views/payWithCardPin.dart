import 'package:Tiwa_Oma/client/views/TransactionReview.dart';
import 'package:Tiwa_Oma/services/Api_service.dart';
import 'package:Tiwa_Oma/services/api.dart';
import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/services/pushNotificationApi.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:Tiwa_Oma/services/Api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class payWithCardPin extends StatefulWidget {
  const payWithCardPin(
      {super.key,
      this.otpHash,
      this.token,
      this.cardDetails1,
      this.booknotifyStylistname,
      this.booknotify});

  final otpHash;
  final token;
  final cardDetails1;
  final booknotify;
  final booknotifyStylistname;
  @override
  State<payWithCardPin> createState() => _payWithCardPinState();
}

class _payWithCardPinState extends State<payWithCardPin> {
  List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    // Dispose of the controllers to avoid memory leaks.
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  late String email = '';
  late final token;
  String username = '';
  String? stylistDeviceToken = '';
  late final number;
  late final id;
  String? deviceToken = '';
  late SharedPreferences prefsDevice;
  @override
  void initState() {
    super.initState();
    if (widget.token.isEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      getuserById();
      print(widget.cardDetails1['card_Number']);
      print(widget.token);
      initSharedPref();
      try {
        Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
        print(widget.token);
        email = jwtDecodedToken['email'];
        username = jwtDecodedToken['username'];
        number = jwtDecodedToken['number'];
        id = jwtDecodedToken['id'];
        print(id);

        print(widget.cardDetails1);
        // id = jwtDecodedToken['id'];
        print(jwtDecodedToken['id']);
      } catch (e) {
        // Handle token decoding errors here, e.g., log the error or show an error message.
        print('Error decoding token: $e');
      }
    }
  }

  void initSharedPref() async {
    prefsDevice = await SharedPreferences.getInstance();
    var tokend = prefsDevice.getString('deviceToken');
    setState(() {
      deviceToken = tokend;
    });
    print("device $deviceToken");
  }

  Future<void> getuserById() async {
    GetUsers.fetchStylistData(widget.token, widget.booknotify['stylistId'])
        .then((res) {
      setState(() {
        stylistDeviceToken = res.data['firebaseToken'];
      });
      print("stylistDeviceToken $stylistDeviceToken");
    });
  }

  @override
  Widget build(BuildContext context) {
    String otp = otpControllers.map((controller) => controller.text).join();
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                'assets/images/mdi-security-lock-outline.svg',
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Enter OTP Pin",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Please enter your pin to proceed",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: GlobalColors.gray),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 4; i++)
                      textFieldOpt(
                          isFirst: i == 0,
                          isLast: i == 3,
                          context: context,
                          controller: otpControllers[i]),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  print(otp);
                  print(widget.cardDetails1);

                  APIService.verifyTransaction1Otp(email, widget.otpHash, otp)
                      .then((res) => {
                            if (res.message == 'success')
                              {
                                APIService.bookingApp(
                                        widget.cardDetails1, widget.token)
                                    .then((respons) {
                                  if (respons.success == true) {
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
                                                Text('${respons.message}',
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
                                    var notify = {
                                      'stylistId':
                                          "${widget.booknotify['stylistId']}",
                                      "userId": "${id}",
                                      "bookingDate": widget
                                          .cardDetails1['appointmentDate'],
                                      'bookingTime':
                                          widget.cardDetails1['appointmentime'],
                                      "bookingId": respons.data['result1']
                                          ['bookingId'],
                                    };
                                    print(notify);
                                    print(respons.data);
                                    APIService.postNotification(
                                            notify, widget.token)
                                        .then((value) {
                                      if (value.success == true) {
                                        PushNotificationApi
                                                .pushNotificationBookingingForUser(
                                                    widget
                                                        .booknotifyStylistname,
                                                    widget.token,
                                                    deviceToken)
                                            .then((value) {
                                          if (value.message ==
                                              'Notification sent successfully') {
                                            PushNotificationApi
                                                    .pushNotificationBookingingForStylist(
                                                        username,
                                                        widget.token,
                                                        stylistDeviceToken)
                                                .then((value) {
                                              if (value.message ==
                                                  'Notification sent successfully') {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          transactionReview(
                                                            token: widget.token,
                                                            bookingId: respons
                                                                        .data[
                                                                    'result1']
                                                                ['bookingId'],
                                                          )),
                                                );
                                              }
                                            });
                                          }
                                        });
                                      }
                                    });
                                  }
                                }),
                              }
                            else if (res.message == 'error')
                              {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 226, 19, 43),
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
                                                res.message,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Spacer(),
                                              Text("Otp Fail",
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
                                ))
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
                  "Verify",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "I did not receive an OTP,",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: GlobalColors.gray),
                ),
                InkWell(
                  onTap: () {
                    APIService.verifyOtp(email, widget.otpHash, otp)
                        .then((res) => {
                              if (res.message == "sussess")
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                            'You will recive An OTP',
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
                                        builder: (context) => payWithCardPin(
                                              otpHash: res.data,
                                              token: widget.token,
                                              cardDetails1: widget.cardDetails1,
                                              booknotify: widget.booknotify,
                                              booknotifyStylistname:
                                                  widget.booknotifyStylistname,
                                            )),
                                  )
                                }
                            });
                    print(widget.cardDetails1);
                  },
                  child: Text(
                    "Resend",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: GlobalColors.blue),
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}

Widget textFieldOpt(
    {required bool isFirst,
    isLast,
    required BuildContext context,
    required controller}) {
  return SizedBox(
    width: 50,
    height: 85,
    child: TextField(
      onChanged: (value) {
        if (value.isNotEmpty && !isLast) {
          FocusScope.of(context).nextFocus();
        }
        if (value.isEmpty && !isFirst) {
          FocusScope.of(context).previousFocus();
        }
      },
      controller: controller,
      maxLength: 1,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      decoration: InputDecoration(
        counter: const Offstage(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2, color: GlobalColors.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2, color: GlobalColors.green),
        ),
      ),
    ),
  );
}
