import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:flutter/material.dart';

import '../../utils/global.colors.dart';
// import 'LastestAppointmentInfo.dart';
import 'TodaysAppointentList.dart';

class TodayAppointmentList extends StatelessWidget {
  const TodayAppointmentList({required this.todayappoimentReview, super.key});
  final List<BookinModel> todayappoimentReview;
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
  TodayAppoimentCard({required this.todayappointment1, super.key});
  final BookinModel todayappointment1;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 9),
            child: InkWell(
              onTap: () {
                print(todayappointment1.userId.username);
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
                                  image: NetworkImage(
                                      "${todayappointment1.hairImg}"),
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
                                      todayappointment1.userId.username,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      todayappointment1.hairName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: GlobalColors.blue),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  todayappointment1.showStatus,
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
                                      todayappointment1.appointmentDate,
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
                                      todayappointment1.appointmentTime,
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
                                      width: 60,
                                    ),
                                    const Icon(
                                      Icons.currency_pound_outlined,
                                      size: 17,
                                    ),
                                    Text(
                                      "${todayappointment1.amount}",
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
