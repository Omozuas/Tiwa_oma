import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DreawerList extends StatelessWidget {
  const DreawerList(
      {super.key,
      required this.title,
      required this.svgSrc,
      required this.tap,
      required this.color,
      required this.color2,
      required this.color3});
  final String title;
  final IconData svgSrc;
  final VoidCallback tap;
  final Color color;
  final Color color2;
  final Color color3;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 208,
      height: 47,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: color3,
          borderRadius: BorderRadiusDirectional.all(Radius.circular(10))),
      child: Center(
        child: ListTile(
          onTap: tap,
          horizontalTitleGap: 0.0,
          leading: FaIcon(
            svgSrc,
            color: color,
          ),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: color2),
          ),
        ),
      ),
    );
  }
}
