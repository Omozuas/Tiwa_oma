import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';

import '../../utils/global.colors.dart';
import 'Bookings.view.dart';
import 'Profile.view.dart';
import 'dashboard.view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
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
              SizedBox(
                height: 20,
              ),
              SettingsMenue(
                onTap: () {},
                text: 'Notifications',
              ),
              SettingsMenue(
                onTap: () {},
                text: 'Password Manager',
              ),
              SettingsMenue(
                onTap: () {},
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
                      Icons.home_filled,
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
                      Icons.book_outlined,
                      size: 32,
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
                      Icons.style,
                      size: 32,
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
                    icon: const Icon(
                      Icons.person_2_outlined,
                      size: 32,
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
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 0),
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
