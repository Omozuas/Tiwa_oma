import 'package:Tiwa_Oma/client/views/BookedSuccess.view.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:flutter/material.dart';

import '../../utils/global.colors.dart';
// import 'LastestAppointmentInfo.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({required this.transactionReview, super.key});
  final List<BookinModel> transactionReview;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: transactionReview
            .map((e) => TransactionCard(transaction: e))
            .toList(),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  TransactionCard({required this.transaction, super.key});
  final BookinModel transaction;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          width: size.width,
          height: 407,
          decoration: BoxDecoration(
            border: Border.all(width: 0.6, color: Colors.white),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
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
                        Text("Stylist",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.shadeblack)),
                        Text("${transaction.stylistId.username} ",
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
                        Text("${transaction.stylistId.address} ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.darkshadeblack)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Name",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.shadeblack)),
                        Text("${transaction.userId.username}",
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
                        Text("${transaction.userId.number} ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.darkshadeblack)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Booking Date",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.shadeblack)),
                        Text("${transaction.appointmentDate}",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.darkshadeblack)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Booking Hour",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.shadeblack)),
                        Text("${transaction.appointmentTime}",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.darkshadeblack)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.shadeblack)),
                        Row(
                          children: [
                            const Icon(
                              Icons.currency_pound_outlined,
                              size: 15,
                            ),
                            Text("${transaction.amount}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.darkshadeblack)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Charges",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.shadeblack)),
                        Row(
                          children: [
                            const Icon(
                              Icons.currency_pound_outlined,
                              size: 15,
                            ),
                            Text("7",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.darkshadeblack)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
