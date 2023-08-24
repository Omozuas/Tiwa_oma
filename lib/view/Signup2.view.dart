import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:Tiwa_Oma/view/verifyEmail.view.dart';
// import 'package:Tiwa_Oma/services/auth_services.dart';
// import 'package:Tiwa_Oma/view/verifyEmail.view.dart';
// import 'package:Tiwa_Oma/view/config.dart';
// import 'package:Tiwa_Oma/view/verifyEmail.view.dart';
import 'dart:convert';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/widgets/signUp_filed.dart';

class Signup2 extends StatefulWidget {
  final String role;
  final Map<String, String> registerBody1;

  const Signup2({super.key, required this.registerBody1, required this.role});

  @override
  State<Signup2> createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  bool _isNotValidate = false;

  Future<void> signupUser() async {
    if (passwordController.text.isNotEmpty &&
        confirmpasswordController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        widget.registerBody1.isNotEmpty) {
      // var registerBody = {
      //   "gender": genderController.text,
      //   "password": passwordController.text,
      //   "confirmPassword": confirmpasswordController.text,
      //   "username": widget.registerBody1['username'] ?? '',
      //   "email": widget.registerBody1['email'] ?? '',
      //   "state": widget.registerBody1['state'] ?? '',
      //   "country": widget.registerBody1['country'] ?? '',
      //   "address": widget.registerBody1['address'] ?? '',
      //   "role": widget.role,
      // };

      // var responsed = await http.post(Uri.parse(registration),
      //     headers: {"Content-Type": "application/json"},
      //     body: jsonEncode(registerBody));
      // var jsonResponse = jsonDecode(responsed.body);
      // print(jsonResponse["success"]);
      // if (jsonResponse["status"]) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerifyEmail(
                    role: widget.role,
                  )));
      // } else {
      //   print("someth went wrong");
      // }
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const VerifyEmail()));
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
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create Account",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Kindly enter your login details to continue",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: GlobalColors.gray),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    signupFiled(
                      label: "gender",
                      hintText: "gender",
                      controller2: genderController,
                      err: _isNotValidate ? "Enter Proper info" : null,
                    ),
                    signupFiled(
                      label: "password",
                      hintText: "Password",
                      obscureText: true,
                      suffixIcon2: const Icon(
                        Icons.visibility_off_outlined,
                      ),
                      controller2: passwordController,
                      err: _isNotValidate ? "Enter Proper info" : null,
                    ),
                    signupFiled(
                      label: "ComfirmPassword",
                      hintText: "ComfirmPassword",
                      obscureText: true,
                      suffixIcon2: const Icon(Icons.visibility_off_outlined),
                      controller2: confirmpasswordController,
                      err: _isNotValidate ? "Enter Proper info" : null,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print(widget.role);
                          signupUser();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29.0),
                            ),
                            minimumSize: const Size(370, 49)),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
