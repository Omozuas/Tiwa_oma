import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:flutter/material.dart';

import '../../utils/global.colors.dart';
// import 'LastestAppointmentInfo.dart';
import 'PreviousDaysAppointmentInfo.dart';
// import 'TodaysAppointentList.dart';

class PriciousDaysAppointmentList extends StatelessWidget {
  const PriciousDaysAppointmentList(
      {required this.previousdaysappoimentReview, super.key});
  final List<BookinModel> previousdaysappoimentReview;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: previousdaysappoimentReview
            .map((e) => PriviousDaysAppoimentCard(priviousdayappointment1: e))
            .toList(),
      ),
    );
  }
}

class PriviousDaysAppoimentCard extends StatelessWidget {
  const PriviousDaysAppoimentCard(
      {required this.priviousdayappointment1, super.key});
  final BookinModel priviousdayappointment1;
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
                print(priviousdayappointment1.userId.username);
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
                                    priviousdayappointment1.hairImg,
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
                                      priviousdayappointment1.userId.username,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      priviousdayappointment1.hairName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: GlobalColors.blue),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 47,
                                ),
                                Text(
                                  priviousdayappointment1.showStatus,
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
                                      priviousdayappointment1.appointmentDate,
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
                                      priviousdayappointment1.appointmentTime,
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
                                      width: 55,
                                    ),
                                    const Icon(
                                      Icons.currency_pound_outlined,
                                      size: 17,
                                    ),
                                    Text(
                                      "${priviousdayappointment1.amount}",
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
