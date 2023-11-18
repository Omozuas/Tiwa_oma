import 'package:Tiwa_Oma/client/views/clientNotification.dart';
import 'package:Tiwa_Oma/services/Api_service.dart';
import 'package:Tiwa_Oma/stylist/AllAppointment.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:Tiwa_Oma/stylist/StylistDashboard.dart';
import 'package:Tiwa_Oma/stylist/stylistProfile.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:Tiwa_Oma/view/RegisterAs.view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

class StylistSettingView extends StatefulWidget {
  const StylistSettingView({super.key, this.token});
  final token;
  @override
  State<StylistSettingView> createState() => _StylistSettingViewState();
}

class _StylistSettingViewState extends State<StylistSettingView> {
  late String email;
  late final token;
  late String username;
  late final id;

  @override
  void initState() {
    super.initState();
    if (widget.token.isEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      try {
        email = jwtDecodedToken['email'];
        id = jwtDecodedToken['id'];
        token = jwtDecodedToken['token'];
        username = jwtDecodedToken['username'];
        print(jwtDecodedToken['email']);
        print(widget.token);
      } catch (e) {
        // Handle token decoding errors here, e.g., log the error or show an error message.
        print('Error decoding token: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
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
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SettingsMenue(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ClientNotification(token: widget.token)));
                },
                text: 'Notifications',
              ),
              SettingsMenue(
                onTap: () {},
                text: 'Password Manager',
              ),
              SettingsMenue(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => DeactivatUser(
                            onTap: () {
                              APIService.deletestylist(id, widget.token)
                                  .then((value) {
                                if (value.message ==
                                    "User account deactivated successfully") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Container(
                                      padding: const EdgeInsets.all(8),
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: GlobalColors.green,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'success',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(value.message,
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterAsView()));
                                }
                              });
                            },
                          ));
                  print(id);
                },
                text: 'Delete Account',
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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistDashboard(
                                    token: widget.token,
                                  )));
                    },
                    icon: const FaIcon(
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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllAppointment(
                                    token: widget.token,
                                  )));
                    },
                    icon: const FaIcon(
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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Clients(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistProfile(
                                    token: widget.token,
                                  )));
                    },
                    icon: Icon(
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

class SettingsMenue extends StatelessWidget {
  const SettingsMenue({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      child: Card(
        elevation: 1,

        // color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: GlobalColors.darkshadeblack),
                    ),
                    FaIcon(FontAwesomeIcons.angleRight,
                        size: 27, color: GlobalColors.yellow),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeactivatUser extends StatelessWidget {
  DeactivatUser({super.key, required this.onTap});
  final onTap;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 53,
                height: 53,
                child: Center(
                    child: FaIcon(
                  Icons.person,
                  color: Colors.red,
                  size: 30,
                )),
                decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(54),
                    color: Colors.red.shade100),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Deactivate Customer",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Are you sure you want to delete this your Account because this can’t be undone",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: GlobalColors.gray,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
                softWrap: true,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 83,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(5),
                            bottom: Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      width: 83,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 243, 33, 33),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(5),
                            bottom: Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          "Deactivate",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
