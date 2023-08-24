import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/stylist/AllAppointment.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:Tiwa_Oma/stylist/StylistAccountInfo.dart';
import 'package:Tiwa_Oma/stylist/StylistDashboard.dart';
import 'package:Tiwa_Oma/stylist/StylistInfomation.dart';
import 'package:Tiwa_Oma/stylist/widgets/StylistProfileMenu.dart';
import 'package:Tiwa_Oma/stylist/widgets/StylistProfilePix.dart';

// import '../client/views/accountInfo.dart';
import '../utils/global.colors.dart';

class StylistProfile extends StatefulWidget {
  const StylistProfile({super.key});

  @override
  State<StylistProfile> createState() => _StylistProfileState();
}

class _StylistProfileState extends State<StylistProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
        elevation: 0,
        backgroundColor: GlobalColors.mainColor,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                StylistproFilePix(),
                SizedBox(
                  height: 20,
                ),
                StylistprofileMenue(
                  icon: FontAwesomeIcons.user,
                  text: 'Account Information',
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StylistAccountInfo()));
                  },
                ),
                StylistprofileMenue(
                  icon: FontAwesomeIcons.brush,
                  text: 'Stylist Infomation',
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StylistInfomation()));
                  },
                ),
                StylistprofileMenue(
                  icon: FontAwesomeIcons.book,
                  text: 'All Bookings',
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllAppointment()));
                  },
                ),
                StylistprofileMenue(
                  icon: FontAwesomeIcons.gear,
                  text: 'Settings',
                  press: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const AccountInfo()));
                  },
                ),
                StylistprofileMenue(
                  icon: FontAwesomeIcons.lock,
                  text: 'Privacy Policy',
                  press: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const AccountInfo()));
                  },
                ),
                StylistprofileMenue(
                  icon: FontAwesomeIcons.triangleExclamation,
                  text: 'Help Center',
                  press: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const AccountInfo()));
                  },
                ),
                StylistprofileMenue(
                  icon: FontAwesomeIcons.rightFromBracket,
                  text: 'Log Out',
                  press: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const AccountInfo()));
                  },
                ),
              ],
            ),
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
                              builder: (context) => const StylistDashboard()));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.house,
                      size: 25,
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
                              builder: (context) => const AllAppointment()));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.book,
                      size: 25,
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
                              builder: (context) => const Clients()));
                    },
                    icon: Icon(
                      Icons.people_outline_sharp,
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
                              builder: (context) => const StylistProfile()));
                    },
                    icon: Icon(
                      Icons.person_2_outlined,
                      size: 25,
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
