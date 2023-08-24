import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/global.colors.dart';

class profileMenue extends StatelessWidget {
  const profileMenue({
    super.key,
    required this.text,
    required this.icon,
    required this.press,
  });
  final String text;
  final VoidCallback press;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      child: Card(
        elevation: 1,

        // color: Colors.white,
        child: InkWell(
          onTap: press,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(icon, size: 27, color: GlobalColors.yellow),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          text,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: GlobalColors.darkshadeblack),
                        ),
                      ],
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
