import 'package:Tiwa_Oma/admin/components/drawer_list_title.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenue extends StatelessWidget {
  const DrawerMenue({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        // child: ListView(children: [
        //   Container(
        //     padding: EdgeInsets.all(4),
        //     child: Image.asset("assets/images/image-3.png"),
        //   ),
        //   DreawerList(title: "Dashboard", svgSrc: Icons.dashboard, tap: () {}),
        //   DreawerList(
        //       title: "Bookings", svgSrc: FontAwesomeIcons.book, tap: () {}),
        //   DreawerList(
        //       title: "Customers",
        //       svgSrc: Icons.people_outline_outlined,
        //       tap: () {}),
        //   DreawerList(title: "Logout", svgSrc: Icons.logout_outlined, tap: () {}),
        // ]),
        );
  }
}
