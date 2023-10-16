import 'package:Tiwa_Oma/services/model/notification_model.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationItemList extends StatefulWidget {
  List<NotificationModel> notifyList = [];
  final token;

  NotificationItemList({super.key, required this.notifyList, this.token});

  @override
  State<NotificationItemList> createState() => _StylistItemListState();
}

class _StylistItemListState extends State<NotificationItemList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.notifyList
          .map((e) => NotificationItemCard(
                notificationModel: e,
                token: widget.token,
              ))
          .toList(),
    );
  }
}

class NotificationItemCard extends StatefulWidget {
  NotificationItemCard(
      {super.key, required this.notificationModel, required this.token});
  NotificationModel notificationModel;

  final token;

  @override
  State<NotificationItemCard> createState() => _StylistItemCardState();
}

class _StylistItemCardState extends State<NotificationItemCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
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
                            child: Center(
                                child: FaIcon(
                              FontAwesomeIcons.book,
                              size: 35,
                              color: Colors.orange.shade500,
                            )),
                            // padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.orange.shade100,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
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
                                'Booked an appointment with ${widget.notificationModel.stylistModel.username}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
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
                                    '${widget.notificationModel.bookingDate}',
                                    // maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: GlobalColors.lightblack,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${widget.notificationModel.bookingTime}',
                                        // maxLines: 1,
                                        style: const TextStyle(
                                            // overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11),
                                      ),
                                    ],
                                  )
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
      ],
    );
  }
}
