import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/client/views/accountInfo.dart';
import 'package:Tiwa_Oma/client/views/AllBookings.dart';
import 'package:Tiwa_Oma/client/views/settingsView.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';

import 'package:Tiwa_Oma/client/views/dashboard.view.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/profileMenue.dart';
import '../../widgets/profilePix.dart';
import 'Bookings.view.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({
    super.key,
  });

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                proFilePix(),
                SizedBox(
                  height: 30,
                ),
                profileMenue(
                  icon: Ionicons.person_outline,
                  text: 'Account Information',
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountInfo()));
                  },
                ),
                profileMenue(
                  icon: LineIcons.book,
                  text: 'All Bookings',
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllBookings()));
                  },
                ),
                profileMenue(
                  icon: Ionicons.cog_outline,
                  text: 'Settings',
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsView()));
                  },
                ),
                profileMenue(
                  icon: Ionicons.lock_closed_outline,
                  text: 'Privacy Policy',
                  press: () {},
                ),
                profileMenue(
                  icon: Ionicons.warning_outline,
                  text: 'Help Center',
                  press: () {},
                ),
                profileMenue(
                  icon: Ionicons.log_out_outline,
                  text: 'Log Out',
                  press: () {},
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
                              builder: (context) => const Dashboard(
                                    token: '',
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
                              builder: (context) => const Bookings()));
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
                              builder: (context) => const Stylist()));
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
                              builder: (context) => const MyProfile()));
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
