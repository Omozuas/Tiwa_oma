import 'package:Tiwa_Oma/services/Api_service.dart';
import 'package:Tiwa_Oma/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
// import 'package:Tiwa_Oma/view/verifyNumber.view.dart';
import 'package:Tiwa_Oma/view/verifyPhone.view.dart';
// import 'dart:convert';
// import 'config.dart';
// import 'package:http/http.dart' as http;
import '../widgets/signUp_filed.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  TextEditingController numberController = TextEditingController();
  String email = '';
  bool _isNotValidate = false;
  Future<void> create() async {
    if (numberController.text.isNotEmpty) {
      var userNumber = numberController.text;
      print(numberController.text);
      await Api.changePassword1(userNumber).then((res) => {
            if (res.message == "user found")
              {
                setState(() {
                  email = res.data;
                  print(res.data);
                }),
                APIService.changepasswordOtp(email).then((value) => {
                      if (value.message == 'success')
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
                                        pinId: value.data,
                                        number: res.data,
                                      )))
                        }
                    })
              }
          });
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
          child: Column(children: <Widget>[
            SvgPicture.asset(
              'assets/images/ep-lock.svg',
              width: 150,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Forgot Password",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Enter your phone number",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: GlobalColors.gray),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: <Widget>[
                  signupFiled(
                    keybordtype1: TextInputType.number,
                    label: "Phone Number",
                    hintText: "Phone Number",
                    suffixIcon2: const Icon(
                      Icons.phone_android_outlined,
                    ),
                    controller2: numberController,
                    err: _isNotValidate ? "Enter Proper info" : null,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
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
                          create();
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
          ]),
        ),
      ),
    );
  }
}
