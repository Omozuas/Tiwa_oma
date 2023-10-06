import 'package:Tiwa_Oma/services/model/vendo_Model.dart';
import 'package:flutter/material.dart';

class DstylistItemdetails extends StatefulWidget {
  DstylistItemdetails({super.key, required this.vendorStylist, this.token});
  List<VendorModelImg> vendorStylist = [];
  final token;
  @override
  State<DstylistItemdetails> createState() => _StylistItemdetailsState();
}

class _StylistItemdetailsState extends State<DstylistItemdetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchVendorData();
    // VendorApi.fetchVendorDataImg(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.vendorStylist
          .map((e) => HairImgItemCard(
                vendorModelImg: e,
                token: widget.token,
              ))
          .toList(),
    );
  }
}

class HairImgItemCard extends StatefulWidget {
  HairImgItemCard(
      {super.key, required this.vendorModelImg, required this.token});
  VendorModelImg vendorModelImg;
  final token;
  @override
  State<HairImgItemCard> createState() => _HairImgItemCardState();
}

class _HairImgItemCardState extends State<HairImgItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 17),
      child: Column(
        children: [
          Container(
            width: 168,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/cartoon.png",
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.vendorModelImg.hairStlye}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            "Hair Stylist",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),

      // Expanded(
      //   child: Column(
      //     children: [
      //       Container(
      //         width: 168,
      //         height: 130,
      //         decoration: BoxDecoration(
      //           color: Colors.black,
      //           borderRadius: BorderRadius.circular(10),
      //           image: DecorationImage(
      //             fit: BoxFit.cover,
      //             image: AssetImage(
      //               "assets/images/cartoon.png",
      //             ),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 8),
      //       Text(
      //         '${widget.vendorModelImg.hairStlye}',
      //         style: const TextStyle(
      //           color: Colors.black,
      //           fontSize: 14,
      //           fontWeight: FontWeight.w500,
      //         ),
      //       ),
      //       const Text(
      //         "Hair Stylist",
      //         style: TextStyle(
      //           color: Colors.grey,
      //           fontSize: 12,
      //           fontWeight: FontWeight.w400,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );

    // Padding(
    //   padding: const EdgeInsets.all(10),
    //   child: GridView.count(
    //     scrollDirection: Axis.vertical,
    //     crossAxisCount: 2, shrinkWrap: true, // Number of columns in the grid
    //     children:
    //         List.generate(widget.vendorModelImg.hairStlye.length, (index) {
    //       return InkWell(
    //         onTap: () {
    //           print(widget.vendorModelImg.stylistModelId);
    //         },
    //         child: Column(
    //           children: [
    //             Container(
    //               width: 168,
    //               height: 130,
    //               decoration: BoxDecoration(
    //                 color: Colors.black,
    //                 borderRadius: BorderRadius.circular(15),
    //                 image: DecorationImage(
    //                   fit: BoxFit.cover,
    //                   image: AssetImage(
    //                     'assets/images/cartoon.png',
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 8),
    //             Text(
    //               '${widget.vendorModelImg.hairStlye}',
    //               style: const TextStyle(
    //                 color: Colors.black,
    //                 fontSize: 14,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //             const Text(
    //               "Hair Stylist",
    //               style: TextStyle(
    //                 color: Colors.grey,
    //                 fontSize: 12,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     }),
    //   ),
    // );
  }
}
