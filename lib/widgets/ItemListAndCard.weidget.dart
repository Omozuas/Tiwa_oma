import 'package:Tiwa_Oma/services/model/review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/global.colors.dart';

class ItemListStateful extends StatefulWidget {
  List<ReviewModel> user;

  ItemListStateful({Key? key, required this.user}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemListStateful> {
  @override
  void initState() {
    super.initState();
    // fetchUserData();
  }

  List<ReviewModel> user = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.user.map((e) => ItemCard(user1: e)).toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  ItemCard({Key? key, required this.user1}) : super(key: key);

  ReviewModel user1;

  List<ReviewModel> user = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Card(
            elevation: 0.9,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                          user1.userId.profileImg.isEmpty
                              ? Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/cartoon.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${user1.userId.profileImg}',
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
                                user1.userId.username,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_outlined,
                                    color: GlobalColors.yellow,
                                  ),
                                  Text('${user1.rating}'),
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            user1.feedback,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
                            softWrap: true,
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
