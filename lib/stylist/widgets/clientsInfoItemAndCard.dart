import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:flutter/material.dart';

class ClientInfoItem extends StatelessWidget {
  ClientInfoItem({required this.userBooking, super.key, this.token});
  final token;
  List<BookinModel2> userBooking = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: userBooking
            .map((e) => ClientInfoCard(
                  userBooking2: e,
                  token: token,
                ))
            .toList(),
      ),
    );
  }
}

class ClientInfoCard extends StatelessWidget {
  ClientInfoCard({super.key, required this.userBooking2, this.token});
  BookinModel2 userBooking2;
  final token;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Center(
          child: Column(
            children: [
              userBooking2.userId.profileImg.isEmpty
                  ? Container(
                      width: 119,
                      height: 119,

                      // padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(54),
                        image: DecorationImage(
                          image: AssetImage("assets/images/rectangle-1047.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: 119,
                      height: 119,

                      // padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(54),
                        image: DecorationImage(
                          image:
                              NetworkImage("${userBooking2.userId.profileImg}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${userBooking2.userId.username}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: GlobalColors.darkshadeblack),
              )
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              width: size.width,
              height: 407,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Name",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.shadeblack)),
                            Text("${userBooking2.userId.username}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.darkshadeblack)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Address",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.shadeblack)),
                            Text("${userBooking2.userId.address}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.darkshadeblack)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Country",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.shadeblack)),
                            Text("${userBooking2.userId.country}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.darkshadeblack)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Phone Number",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.shadeblack)),
                            Text("${userBooking2.userId.number}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.darkshadeblack)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Email Address",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.shadeblack)),
                            Text("${userBooking2.userId.email}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.darkshadeblack)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("No of Appointment",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.shadeblack)),
                            Text("${userBooking2.bookingCount}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.darkshadeblack)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 55,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29.0),
                        ),
                        minimumSize: const Size(370, 49)),
                    child: const Text(
                      "Return",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
