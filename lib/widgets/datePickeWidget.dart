import 'package:flutter/material.dart';

import '../utils/global.colors.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    Key? key,
    required this.isWeekend,
    required this.currentIndex4,
    required this.onTimeSelected,
  }) : super(key: key);

  final bool isWeekend;
  final int? currentIndex4;
  final void Function(int index)? onTimeSelected;

  @override
  Widget build(BuildContext context) {
    if (isWeekend) {
      return Container(
        // You can add your weekend-specific content here

        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        child: const Text("We are not Opened"),
      );
    } else {
      return Wrap(children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: 8,
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                if (onTimeSelected != null) {
                  onTimeSelected!(index);
                }
              },
              child: Container(
                margin: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: currentIndex4 == index
                      ? Colors.yellow
                      : GlobalColors.gray2,
                ),
                alignment: Alignment.center,
                child: Text(
                  "${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: currentIndex4 == index
                        ? Colors.white
                        : GlobalColors.gray3,
                  ),
                ),
              ),
            );
          },
        ),
      ]);
    }
  }
}
