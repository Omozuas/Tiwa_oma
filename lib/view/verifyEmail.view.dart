import 'package:Tiwa_Oma/services/Api_service.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyEmail extends StatefulWidget {
  final String accountType;

  final Map<String, String> registerBody1;
  final String? otphash;
  final token;
  const VerifyEmail({
    super.key,
    required this.accountType,
    required this.registerBody1,
    this.otphash,
    required this.token,
  });

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late Future<SharedPreferences> prefsFuture;

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

  Future<void> verifyOTP() async {
    String otp = otpControllers.map((controller) => controller.text).join();
    APIService.verifyOtp(widget.registerBody1['email']!, widget.otphash!, otp)
        .then((response) async {
      print(response.message);
      print(response.data);
      print(otp);
      if (response.data != null) {
        if (widget.accountType == 'client') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login()));
        } else if (widget.accountType == 'stylist') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login()));
        }
      }
    });
  }

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
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: SizedBox(
                            height: 85,
                            child: AspectRatio(
                              aspectRatio: 0.9,
                              child: TextField(
                                controller: otpControllers[index],
                                autofocus: index == 0,
                                onChanged: (value) {
                                  if (value.length == 1 && index < 3) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                  if (value.isEmpty && index > 0) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                showCursor: false,
                                readOnly: false,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                    counter: const Offstage(),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: GlobalColors.gray)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: GlobalColors.green))),
                              ),
                            )),
                      );
                    })),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  verifyOTP();
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
}
