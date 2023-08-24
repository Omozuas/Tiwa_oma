import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/widgets/photos.widget.dart';

class HairCard extends StatelessWidget {
  const HairCard({
    super.key,
    required this.reviewPhotos,
  });
  final Photos reviewPhotos;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            width: 0.1,
            color: Colors.grey.shade400,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 169,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(reviewPhotos.imagurl),
              ),
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("data"), Text("data")],
          )
        ],
      ),
    );
  }
}
