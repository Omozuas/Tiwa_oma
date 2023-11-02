import 'package:Tiwa_Oma/services/Api_service.dart';
import 'package:Tiwa_Oma/services/api.dart';
import 'package:flutter/material.dart';
// import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:Tiwa_Oma/view/verifyEmail.view.dart';
// import 'package:Tiwa_Oma/services/auth_services.dart';
// import 'package:Tiwa_Oma/view/verifyEmail.view.dart';
// import 'package:Tiwa_Oma/view/config.dart';
// import 'package:Tiwa_Oma/view/verifyEmail.view.dart';
// import 'dart:convert';
// import 'config.dart';
// import 'package:http/http.dart' as http;
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/widgets/signUp_filed.dart';

class Signup2 extends StatefulWidget {
  final String accountType;
  final Map<String, String> registerBody1;

  const Signup2(
      {super.key, required this.registerBody1, required this.accountType});

  @override
  State<Signup2> createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // bool _isNotValidate = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  Future<void> signupUser() async {
    if (formKey.currentState!.validate() &&
        formKey1.currentState!.validate() &&
        formKey2.currentState!.validate()) {
      // final snackBar = SnackBar(content: Text('proseed'));
      // _scaffoldkey.currentState!.setState(() {
      //   snackBar;
      // });

      var registerBody = {
        "gender": genderController.text,
        "password": passwordController.text,
        "confirmPassword": confirmpasswordController.text,
        ...widget.registerBody1
      };
      Api.addUser(registerBody).then((respons) {
        if (respons.status == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              padding: const EdgeInsets.all(8),
              height: 80,
              decoration: BoxDecoration(
                color: GlobalColors.green,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'success',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Text(respons.message,
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

          APIService.registerOpt(widget.registerBody1['email']!)
              .then((response) async {
            print(response.message);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
                padding: const EdgeInsets.all(8),
                height: 80,
                decoration: BoxDecoration(
                  color: GlobalColors.green,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'success',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(respons.message,
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

            print(response.data);
            print(respons.token);

            if (response.data != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerifyEmail(
                            accountType: widget.accountType,
                            registerBody1: widget.registerBody1,
                            otphash: response.data,
                            token: respons.token,
                          )));
            }
          });
        } else {
          print('failed to register user');

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Card(
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 80,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 240, 23, 49),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        Text(respons.message,
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
                        keys: formKey,
                        label: "GENDER",
                        hintText: "Gender",
                        controller2: genderController,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                            return "Enter Your Gender";
                          } else {
                            return null;
                          }
                        }),
                    signupFiled(
                        keys: formKey1,
                        label: "PASSWORD",
                        hintText: "Password",
                        obscureText: !_isVisible,
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
                        controller2: passwordController,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^.*$').hasMatch(value!)) {
                            return "Enter Your Password";
                          } else {
                            return null;
                          }
                        }),
                    signupFiled(
                        keys: formKey2,
                        label: "COMFIRMPASSWORD",
                        hintText: "ComfirmPassword",
                        obscureText: !_isVisible,
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
                        controller2: confirmpasswordController,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^.*$').hasMatch(value!)) {
                            return "Enter Your ComfirmPassword";
                          } else if (passwordController.text.isEmpty ||
                              confirmpasswordController.text.isEmpty) {
                            return 'Both fields are required.';
                          } else if (passwordController.text !=
                              confirmpasswordController.text) {
                            return 'Passwords do not match.';
                          } else {
                            return null;
                          }
                        }),
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
                          // _successMessage(context);
                          print(widget.accountType);
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

  _successMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: const EdgeInsets.all(8),
        height: 80,
        decoration: BoxDecoration(
          color: GlobalColors.green,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: const Row(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'success',
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
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
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
