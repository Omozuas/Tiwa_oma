import 'package:Tiwa_Oma/widgets/dropDownBtn.dart';
import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/Signup2.view.dart';
import 'package:Tiwa_Oma/widgets/signUp_filed.dart';

class Signup extends StatefulWidget {
  const Signup({super.key, required this.role});
  final String role;

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool _isNotValidate = false;
  // String valueChoose = 'lagos';
  // List<dynamic> countries = [];
  // String? countryId;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   this.countries.add({'id': 1, "label": "nigeria"});
  //   this.countries.add({'id': 2, "label": "uk"});
  // }

  void create() async {
    if (emailController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        widget.role.isNotEmpty) {
      // var responsed = await http.post(Uri.parse(registration),
      //     headers: {"Content-Type": "application/json"},
      //     body: jsonEncode(registerBody));
      // print(responsed);
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
                      label: "Username",
                      hintText: "Username",
                      controller2: usernameController,
                      err: _isNotValidate ? "Enter Proper info" : null,
                    ),
                    signupFiled(
                      label: "Email",
                      hintText: "Email",
                      controller2: emailController,
                      err: _isNotValidate ? "Enter Proper info" : null,
                    ),
                    signupFiled(
                      label: "Address",
                      hintText: "Address",
                      controller2: addressController,
                      err: _isNotValidate ? "Enter Proper info" : null,
                    ),
                    signupFiled(
                      label: "State",
                      hintText: "State",
                      controller2: stateController,
                      err: _isNotValidate ? "Enter Proper info" : null,
                    ),
                    signupFiled(
                      label: "country",
                      hintText: "Country",
                      controller2: countryController,
                      err: _isNotValidate ? "Enter Proper info" : null,
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
                            print(widget.role);
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
                                          },
                                          role: widget.role,
                                        )));
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
