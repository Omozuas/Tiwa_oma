import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/services/updateApi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:Tiwa_Oma/stylist/stylistProfile.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import '../utils/global.colors.dart';
import '../widgets/signUp_filed.dart';
import 'AllAppointment.dart';
import 'StylistDashboard.dart';

class StylistAccountInfo extends StatefulWidget {
  StylistAccountInfo({super.key, this.token});
  var token;
  @override
  State<StylistAccountInfo> createState() => _StylistAccountInfoState();
}

class _StylistAccountInfoState extends State<StylistAccountInfo> {
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

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  void UpDateStylistAccount() async {
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
          getuserById(id);
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
      body: RefreshIndicator(
        onRefresh: () async {
          await getuserById(id);
        },
        child: SingleChildScrollView(
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
                        label: "Username",
                        hintText: "${username}",
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
                        label: "Email",
                        hintText: "${email}",
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
                        label: "Gender",
                        hintText: "${gender}",
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
                        label: "Address",
                        hintText: "${address}",
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
                        hintText: "${state}",
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
                        label: "Country",
                        hintText: "${country}",
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
                            UpDateStylistAccount();
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
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistDashboard(
                                    token: widget.token,
                                  )));
                    },
                    child: const FaIcon(
                      LineIcons.home,
                      size: 30,
                    ),
                  ),
                  const Text(
                    'Home',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllAppointment(
                                    token: widget.token,
                                  )));
                    },
                    child: const FaIcon(
                      LineIcons.book,
                      size: 30,
                    ),
                  ),
                  const Text('Appointment'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Clients(
                                    token: widget.token,
                                  )));
                    },
                    child: const Icon(
                      Ionicons.people_outline,
                      size: 32,
                    ),
                  ),
                  Text(
                    'client',
                    style: TextStyle(color: GlobalColors.darkshadeblack),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistProfile(
                                    token: widget.token,
                                  )));
                    },
                    child: Icon(
                      Ionicons.person_outline,
                      size: 30,
                      color: GlobalColors.yellow,
                    ),
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(color: GlobalColors.yellow),
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
