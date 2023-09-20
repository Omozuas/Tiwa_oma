import 'package:flutter/material.dart';
// import 'package:Tiwa_Oma/stylist/widgets/TodaysAppointentList.dart';

import '../../utils/global.colors.dart';
// import 'LastestAppointmentInfo.dart';
// import 'TodaysAppointentList.dart';
import 'YestadayAppoinmentInnfo.dart';

class YestadayAppointmentList extends StatelessWidget {
  const YestadayAppointmentList({
    required this.yestadayappoimentReview,
    super.key,
  });
  final List<YestadayAppointment> yestadayappoimentReview;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: yestadayappoimentReview
            .map((e) => TodayAppoimentCard(yestadayappointment2: e))
            .toList(),
      ),
    );
  }
}

class TodayAppoimentCard extends StatelessWidget {
  const TodayAppoimentCard({required this.yestadayappointment2, super.key});
  final YestadayAppointment yestadayappointment2;
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
                print(yestadayappointment2.name +
                    yestadayappointment2.amount +
                    yestadayappointment2.hairname);
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
                                    yestadayappointment2.imgurl,
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
                                      yestadayappointment2.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      yestadayappointment2.hairname,
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
                                  yestadayappointment2.status,
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
                                      yestadayappointment2.date,
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
                                      yestadayappointment2.time,
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
                                      yestadayappointment2.amount,
                                      // maxLines: 1,
                                      style: TextStyle(
                                          // overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w600,
                                          color: GlobalColors.darkshadeblack,
                                          fontSize: 17),
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
