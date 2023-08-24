import 'package:flutter/material.dart';

import '../utils/global.colors.dart';

Widget TextLocation() => Positioned(
      top: 350,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.location_on_outlined,
          color: Colors.red,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          "23, Osborne ikoyi lagos State",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: GlobalColors.gray),
        )
      ]),
    );
