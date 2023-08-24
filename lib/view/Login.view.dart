import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/ForgotPassword.view.dart';
import 'package:Tiwa_Oma/view/Signuo.view.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
// import 'package:Tiwa_Oma/view/verifyEmail.view.dart';
import 'package:Tiwa_Oma/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'config.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _isNotValidate = false;

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUsers() async {
    if (passwordcontroller.text.isNotEmpty && emailcontroller.text.isNotEmpty) {
      var registerBody2 = {
        "password": passwordcontroller.text,
        "email": emailcontroller.text,
      };
      var response = await http.post(Uri.parse(loginUser),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(registerBody2));

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['success']);
      // print(jsonResponse['token']);
      // print(emailcontroller.text);
      print(prefs);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString(jsonResponse['token'], myToken);
        // print(myToken);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Dashboard(
                      token: myToken,
                    )));
      } else {
        print("something went wrong");
      }
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "Log in",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Kindly enter your login details to continue",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: GlobalColors.gray),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: <Widget>[
                    textFiled(
                        label: "Email",
                        hintText: "Email",
                        suffixIcon2: const Icon(Icons.email),
                        controller2: emailcontroller,
                        err: _isNotValidate ? "Enter Proper info" : null,
                        keyboardType4: TextInputType.emailAddress),
                    textFiled(
                        label: "Password",
                        hintText: "password",
                        suffixIcon2: const Icon(Icons.visibility_off),
                        controller2: passwordcontroller,
                        err: _isNotValidate ? "Enter Proper info" : null,
                        obscureText: true,
                        keyboardType4: TextInputType.visiblePassword),
                    const SizedBox(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          child: Text(
                            "Fogot password ?",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.blue,
                                fontSize: 14),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const forgotPassword()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            loginUsers();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Dashboard()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29.0),
                              ),
                              minimumSize: const Size(370, 49)),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Dont have an account?"),
                  GestureDetector(
                      child: Text(
                        "Sign UP",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: GlobalColors.blue),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signup(
                                      role: '',
                                    )));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
