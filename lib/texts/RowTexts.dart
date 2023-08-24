import 'package:flutter/material.dart';

import '../utils/global.colors.dart';

Widget rowText() => Positioned(
      top: 220,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              Icon(
                Icons.star_border_outlined,
                size: 35,
                color: GlobalColors.yellow,
                weight: 500,
              ),
              const SizedBox(
                width: 3,
              ),
              Text("(5.0)",
                  style: TextStyle(color: GlobalColors.gray, fontSize: 17)),
              const SizedBox(
                width: 205,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: 75,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 136, 236, 139),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(100), bottom: Radius.circular(100)),
                ),
                child: const Center(
                  child: Text(
                    "open",
                    style: TextStyle(
                        color: Color.fromARGB(255, 27, 120, 30), fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
