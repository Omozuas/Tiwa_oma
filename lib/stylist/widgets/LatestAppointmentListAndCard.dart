import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:flutter/material.dart';
import '../../utils/global.colors.dart';

class AppointmentList extends StatelessWidget {
  AppointmentList({required this.userBooking, super.key});

  List<BookinModel> userBooking = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children:
            userBooking.map((e) => AppoimentCard(userBooking2: e)).toList(),
      ),
    );
  }
}

class AppoimentCard extends StatelessWidget {
  AppoimentCard({required this.userBooking2, super.key});
  BookinModel userBooking2;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 9),
            child: InkWell(
              onTap: () {
                print(userBooking2.hairName);
                print(userBooking2.appointmentTime);
                print(userBooking2.userId);
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
                            userBooking2.userId.profileImg.isEmpty
                                ? Container(
                                    width: 70,
                                    height: 70,

                                    // padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(54),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/rectangle-1041.jpg",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 70,
                                    height: 70,

                                    // padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(54),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "${userBooking2.userId.profileImg}",
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
                                      '${userBooking2.userId.username}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      '${userBooking2.hairName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: GlobalColors.blue),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 87,
                                ),
                                if (userBooking2.showStatus == 'paid')
                                  Text(
                                    '${userBooking2.showStatus}',
                                    // maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: GlobalColors.green,
                                    ),
                                  ),
                                if (userBooking2.showStatus == "Pending")
                                  Text(
                                    '${userBooking2.showStatus}',
                                    // maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.red,
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
                                      '${userBooking2.appointmentDate}',
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
                                      '${userBooking2.appointmentTime}',
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
                                      width: 80,
                                    ),
                                    const Icon(
                                      Icons.currency_pound_outlined,
                                      size: 17,
                                    ),
                                    Text(
                                      '${userBooking2.amount}',
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
