import 'package:Tiwa_Oma/services/Api_service.dart';
import 'package:Tiwa_Oma/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/setNewPassword.view.dart';

class Verifyphone extends StatefulWidget {
  const Verifyphone({super.key, this.pinId, this.number});
  final pinId;

  final number;
  @override
  State<Verifyphone> createState() => _VerifyphoneState();
}

class _VerifyphoneState extends State<Verifyphone> {
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

  @override
  Widget build(BuildContext context) {
    String otp = otpControllers.map((controller) => controller.text).join();
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/fluent-phone-chat-20-regular.svg',
                width: 150,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Verify Phone Number",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Kindly enter the OTP sent to you phone number",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: GlobalColors.gray),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < 4; i++)
                            textFieldOpt(
                                isFirst: i == 0,
                                isLast: i == 3,
                                context: context,
                                controller: otpControllers[i]),
                        ]),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            APIService.verifyChangepassword1Otp(
                                    widget.number, widget.pinId, otp)
                                .then((res) => {
                                      if (res.message == 'success')
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      setNewPassword(
                                                        userNumber:
                                                            widget.number,
                                                      ))),
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
                                                    '${res.message}',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              duration: Duration(seconds: 3),
                                            ),
                                          )
                                        },
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
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    APIService.changepasswordOtp(widget.number).then((res) => {
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
                                        'You will get an Otp PIN via email',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  duration: Duration(seconds: 13),
                                ),
                              ),
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Verifyphone(
                                            pinId: res.data,
                                            number: widget.number,
                                          )))
                            }
                        });
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
}
