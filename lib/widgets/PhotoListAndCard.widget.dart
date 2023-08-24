// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:Tiwa_Oma/widgets/photos.widget.dart';

class PhotoList extends StatelessWidget {
  const PhotoList({required this.categoryPhotos, super.key});
  final List<Photos> categoryPhotos;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: categoryPhotos.map((e) => PhotoCard(reviewPhotos: e)).toList(),
    );
  }
}

class PhotoCard extends StatelessWidget {
  const PhotoCard({required this.reviewPhotos, super.key});
  final Photos reviewPhotos;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    print(reviewPhotos.name + reviewPhotos.amount);
                  },
                  child: Stack(
                    children: [
                      Card(
                        elevation: 0.9,
                        child: Container(
                          width: 172,
                          height: 129,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                reviewPhotos.imagurl,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reviewPhotos.name,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(Icons.currency_pound_outlined),
                    Text(
                      reviewPhotos.amount,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    print(reviewPhotos.name + reviewPhotos.amount);
                  },
                  child: Stack(
                    children: [
                      Card(
                        elevation: 0.9,
                        child: Container(
                          width: 172,
                          height: 129,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                reviewPhotos.imagurl,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reviewPhotos.name,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(Icons.currency_pound_outlined),
                    Text(
                      reviewPhotos.amount,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //button
        ],
      ),
    );
  }
}
