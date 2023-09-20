import 'package:Tiwa_Oma/client/views/stylistReviews.view.dart';
import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:flutter/material.dart';

class StylistItemList extends StatefulWidget {
  List<StylistModel> nameStylist = [];
  final token;

  StylistItemList({super.key, required this.nameStylist, this.token});

  @override
  State<StylistItemList> createState() => _StylistItemListState();
}

class _StylistItemListState extends State<StylistItemList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.nameStylist
          .map((e) => StylistItemCard(
                stylistModel: e,
                token: widget.token,
              ))
          .toList(),
    );
  }
}

class StylistItemCard extends StatefulWidget {
  StylistItemCard({super.key, required this.stylistModel, required this.token});
  StylistModel stylistModel;

  final token;

  @override
  State<StylistItemCard> createState() => _StylistItemCardState();
}

class _StylistItemCardState extends State<StylistItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print(widget.stylistModel.id.runtimeType);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => stylistReview(
                            token: widget.token,
                            stylistModel: widget.stylistModel,
                          )));
            },
            child: widget.stylistModel.profileImg == null
                ? Container(
                    width: 82,
                    height: 82, // Adjust the size of the image container
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(82),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/cartoon.png"),
                      ),
                    ),
                  )
                : Container(
                    width: 82,
                    height: 82, // Adjust the size of the image container
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(82),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage("${widget.stylistModel.profileImg}"),
                      ),
                    ),
                  ),
          ),
          const SizedBox(
              height: 8), // Adjust the spacing between image and text
          Text(
            widget.stylistModel.username,
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const Text(
            "Hair Stylist",
            style: TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
