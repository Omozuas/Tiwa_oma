import 'package:flutter/material.dart';

import '../../utils/global.colors.dart';
// import 'LastestAppointmentInfo.dart';
import 'TodaysAppointentList.dart';

class TodayAppointmentList extends StatelessWidget {
  const TodayAppointmentList({required this.todayappoimentReview, super.key});
  final List<TodaysAppointment> todayappoimentReview;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: todayappoimentReview
            .map((e) => TodayAppoimentCard(todayappointment1: e))
            .toList(),
      ),
    );
  }
}

class TodayAppoimentCard extends StatelessWidget {
  const TodayAppoimentCard({required this.todayappointment1, super.key});
  final TodaysAppointment todayappointment1;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 9),
            child: InkWell(
              onTap: () {
                print(todayappointment1.name +
                    todayappointment1.amount +
                    todayappointment1.hairname);
              },
              child: Row(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 70,
                              height: 70,

                              // padding: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(54),
                                image: DecorationImage(
                                  image: AssetImage(
                                    todayappointment1.imgurl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      todayappointment1.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      todayappointment1.hairname,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: GlobalColors.blue),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  todayappointment1.status,
                                  // maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: GlobalColors.green,
                                  ),
                                ),
                                const SizedBox(
                                  width: 0,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      todayappointment1.date,
                                      // maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: GlobalColors.lightblack,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 9,
                                    ),
                                    Text(
                                      todayappointment1.time,
                                      // maxLines: 1,
                                      style: const TextStyle(
                                          // overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 75,
                                    ),
                                    const Icon(
                                      Icons.currency_pound_outlined,
                                      size: 17,
                                    ),
                                    Text(
                                      todayappointment1.amount,
                                      // maxLines: 1,
                                      style: TextStyle(
                                          // overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w600,
                                          color: GlobalColors.darkshadeblack,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
