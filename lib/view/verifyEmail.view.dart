import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Tiwa_Oma/stylist/StylistDashboard.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';

class VerifyEmail extends StatefulWidget {
  final String role;
  const VerifyEmail({super.key, required this.role});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/dashicons-email-alt-2.svg',
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Verify Code",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Please enter the code we sent to your email address",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: GlobalColors.gray),
                textAlign: TextAlign.center,
              ),
              Text(
                "example@gmail.com",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: GlobalColors.blue),
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
                          isFirst: i == 0, isLast: i == 3, context: context),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget.role == 'client') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard(
                                  token: '',
                                  // token: myToken,
                                )));
                  } else if (widget.role == 'stylist') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StylistDashboard(
                                // token: '',
                                // token: myToken,
                                )));
                  }
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
                Text(
                  "Resend",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: GlobalColors.blue),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldOpt(
      {required bool isFirst, isLast, required BuildContext context}) {
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
}
