import 'dart:convert';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
import 'package:Tiwa_Oma/stylist/StylistDashboard.dart';
import 'package:Tiwa_Oma/view/config.dart';
import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/ForgotPassword.view.dart';
import 'package:Tiwa_Oma/view/Signuo.view.dart';
import 'package:Tiwa_Oma/widgets/text_field.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

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
    if (formKey.currentState!.validate() && formKey1.currentState!.validate()) {
      var loginBody = {
        "password": passwordcontroller.text,
        "email": emailcontroller.text,
      };
      var response = await http.post(Uri.parse(loginUser),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(loginBody));

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        var myToken = jsonResponse['token'];

        prefs.setString('token', myToken);
        print(myToken);
        print(jsonResponse['success']);
        print(jsonResponse['token']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 29,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  jsonResponse['success'],
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
            duration: Duration(seconds: 3),
          ),
        );

        Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(myToken);
        print(jsonResponse['accountType']);
        // print(prefs.toString());
        if (jwtDecodedToken['accountType'] == 'client') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Dashboard(
                        token: myToken,
                        // token: myToken,
                      )));
        } else if (jwtDecodedToken['accountType'] == 'stylist') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StylistDashboard(
                        token: myToken,
                      )));
        }
        // Api.loginUser(loginBody);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 29,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  jsonResponse['message'],
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      print("something went wrong");
    }
  }

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
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
                        keys: formKey,
                        label: "Email",
                        hintText: "Email",
                        suffixIcon2: const Icon(Icons.email),
                        controller2: emailcontroller,
                        keyboardType4: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                  .hasMatch(value!)) {
                            return "Enter Your email";
                          } else {
                            return null;
                          }
                        }),
                    textFiled(
                        keys: formKey1,
                        label: "Password",
                        hintText: "password",
                        controller2: passwordcontroller,
                        obscureText: !_isVisible,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^.*$').hasMatch(value!)) {
                            return "Enter Your Password";
                          } else {
                            return null;
                          }
                        },
                        suffixIcon2: IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: _isVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off_outlined),
                          color: GlobalColors.darkshadeblack,
                        ),
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
                                      accountType: '',
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
