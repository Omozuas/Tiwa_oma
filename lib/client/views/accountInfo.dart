import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/services/updateApi.dart';
import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/signUp_filed.dart';
import 'Bookings.view.dart';
import 'Profile.view.dart';
import 'dashboard.view.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key, this.token});
  final token;
  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String email = '';
  String username = '';
  String gender = '';
  String address = '';
  String state = '';
  String country = '';
  late final id;

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    try {
      id = jwtDecodedToken['id'];
      getuserById(id);
      print(jwtDecodedToken['email']);
      print(widget.token);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
  }

  Future<void> getuserById(id) async {
    GetUsers.fetchStylistData(widget.token, id).then((res) {
      setState(() {
        email = res.data['email'];
        username = res.data['username'];

        gender = res.data['gender'];
        address = res.data['address'];
        state = res.data['state'];
        country = res.data['country'];
        emailController.text = email;
        usernameController.text = username;
        genderController.text = gender;
        stateController.text = state;
        addressController.text = address;
        countryController.text = country;
      });
    });
  }

  void UpDateUsertAccount() async {
    if (formKey.currentState!.validate() &&
        formKey1.currentState!.validate() &&
        formKey2.currentState!.validate() &&
        formKey3.currentState!.validate() &&
        formKey4.currentState!.validate() &&
        formKey5.currentState!.validate()) {
      var updateUser = {
        "email": emailController.text,
        "username": usernameController.text,
        "state": stateController.text,
        "country": countryController.text,
        "address": addressController.text,
        "gender": genderController.text
      };
      print(updateUser);
      UpdateuserInfoApi.updateUser(updateUser, widget.token, id).then((res) {
        if (res.success == true) {
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
                    '${res.message}',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 29,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${res.message}',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
              duration: Duration(seconds: 3),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Account Information"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
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
                      keys: formKey3,
                      label: "ADDRESS",
                      hintText: "Address",
                      controller2: addressController,
                      validate: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
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
                          UpDateUsertAccount();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29.0),
                            ),
                            minimumSize: const Size(370, 49)),
                        child: const Text(
                          "Update",
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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: SizedBox(
          height: 69,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dashboard(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
                      LineIcons.home,
                      size: 32,
                    ),
                  ),
                  const Text(
                    'Home',
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bookings(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
                      LineIcons.book,
                      size: 30,
                    ),
                  ),
                  const Text('Bookings'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Stylist(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
                      Ionicons.cut_outline,
                      size: 30,
                    ),
                  ),
                  const Text('stylist'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyProfile(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
                      Ionicons.person_outline,
                      size: 30,
                      color: Colors.yellow,
                    ),
                  ),
                  const Text(
                    'Profile',
                    style: TextStyle(color: Colors.yellow),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
