import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/stylist/ClientsDetails.dart';
import '../../utils/global.colors.dart';

class ClientstList extends StatelessWidget {
  ClientstList({required this.userBooking, super.key});

  List<BookinModel2> userBooking = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: userBooking.map((e) => ClientCard(userBooking2: e)).toList(),
      ),
    );
  }
}

class ClientCard extends StatelessWidget {
  ClientCard({required this.userBooking2, super.key});
  BookinModel2 userBooking2;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Card(
            elevation: .4,
            margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
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
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/cartoon.png',
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
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${userBooking2.userId.profileImg}',
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
                              Text(
                                '${userBooking2.userId.username}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ClientsDetails(
                                                    userId:
                                                        userBooking2.userId.id,
                                                  )));
                                      print(userBooking2.userId.id);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: GlobalColors.yellow,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(100),
                                                bottom: Radius.circular(100)),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "view",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Row(
                            children: [
                              Text(
                                '${userBooking2.userId.email}',
                                // maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: GlobalColors.lightblack,
                                ),
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
