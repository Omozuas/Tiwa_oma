import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/Signup2.view.dart';
import 'package:Tiwa_Oma/widgets/signUp_filed.dart';

class Signup extends StatefulWidget {
  const Signup({super.key, required this.accountType});
  final String accountType;

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  void create() async {
    if (formKey.currentState!.validate() &&
        formKey1.currentState!.validate() &&
        formKey2.currentState!.validate() &&
        formKey3.currentState!.validate() &&
        formKey4.currentState!.validate() &&
        formKey5.currentState!.validate()) {
      const snackBar = SnackBar(content: Text('proseed'));
      _scaffoldkey.currentState!.setState(() {
        snackBar;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Signup2(
                    registerBody1: {
                      "username": usernameController.text,
                      "email": emailController.text,
                      "state": stateController.text,
                      "country": countryController.text,
                      "address": addressController.text,
                      "accountType": widget.accountType,
                      "number": numberController.text
                    },
                    accountType: widget.accountType,
                  )));
    }
  }

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
                    "Create Account",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
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
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    signupFiled(
                        keys: formKey,
                        label: "USERNAME",
                        hintText: "Username",
                        controller2: usernameController,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                            return "Enter Your User Name";
                          } else {
                            return null;
                          }
                        }),
                    signupFiled(
                        keys: formKey1,
                        label: "EMAIL",
                        hintText: "Email",
                        controller2: emailController,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                  .hasMatch(value!)) {
                            return "Enter Your email";
                          } else {
                            return null;
                          }
                        }),
                    signupFiled(
                        keys: formKey2,
                        label: "NUMBER",
                        hintText: "Number",
                        controller2: numberController,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                                  .hasMatch(value!)) {
                            return "Enter Your Number";
                          } else {
                            return null;
                          }
                        }),
                    signupFiled(
                        keys: formKey3,
                        label: "ADDRESS",
                        hintText: "Address",
                        controller2: addressController,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w\s.,#-]+$').hasMatch(value!)) {
                            return "Enter Your Address";
                          } else {
                            return null;
                          }
                        }),
                    signupFiled(
                        keys: formKey4,
                        label: "State",
                        hintText: "State",
                        controller2: stateController,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                            return "Enter Your State";
                          } else {
                            return null;
                          }
                        }),
                    signupFiled(
                        keys: formKey5,
                        label: "COUNTRY",
                        hintText: "Country",
                        controller2: countryController,
                        validate: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                            return "Enter Your Country";
                          } else {
                            return null;
                          }
                        }),
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
                            create();
                            print(widget.accountType);
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
    );
  }
}
