import 'package:flutter/material.dart';

import '../utils/global.colors.dart';
import 'Review.view.dart';

class ItemList extends StatelessWidget {
  const ItemList({required this.categoryReview, super.key});
  final List<Review> categoryReview;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: categoryReview.map((e) => ItemCard(review: e)).toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({required this.review, super.key});
  final Review review;
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
                          Container(
                            width: 60,
                            height: 60,

                            // padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  review.imgurl,
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
                              Text(review.name),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_outlined,
                                    color: GlobalColors.yellow,
                                  ),
                                  Text(review.rating),
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
                            review.description,
                            // maxLines: 1,
                            style: const TextStyle(
                                // overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                                fontSize: 17),
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
