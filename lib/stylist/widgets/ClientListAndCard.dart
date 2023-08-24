import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/stylist/ClientsDetails.dart';
import 'package:Tiwa_Oma/stylist/widgets/ClientsInfo.dart';

import '../../utils/global.colors.dart';
// import 'LastestAppointmentInfo.dart';

class ClientstList extends StatelessWidget {
  const ClientstList({required this.clientsReview, super.key});
  final List<ClientInfo> clientsReview;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: clientsReview.map((e) => ClientCard(clients1: e)).toList(),
      ),
    );
  }
}

class ClientCard extends StatelessWidget {
  const ClientCard({required this.clients1, super.key});
  final ClientInfo clients1;
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
                          Container(
                            width: 70,
                            height: 70,

                            // padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              image: DecorationImage(
                                image: AssetImage(
                                  clients1.imgurl,
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
                                clients1.name,
                                style: TextStyle(
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
                                                  const ClientsDetails()));
                                      print(clients1.name +
                                          clients1.gmail +
                                          clients1.imgurl);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: GlobalColors.yellow,
                                        borderRadius: BorderRadius.vertical(
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
                                clients1.gmail,
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
