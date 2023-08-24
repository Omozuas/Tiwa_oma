import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/global.colors.dart';

class StylistproFilePix extends StatelessWidget {
  const StylistproFilePix({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: GlobalColors.yellow,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: GlobalColors.blue,
                        width: 3,
                      ),
                    ),
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/memoji-boys-5231.png",
                        )),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: GlobalColors.green,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: FaIcon(FontAwesomeIcons.pencil,
                            size: 20, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          "Alex Samuel",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
