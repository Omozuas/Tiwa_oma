import 'package:Tiwa_Oma/services/model/admin_model.dart';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminRecordList extends StatelessWidget {
  AdminRecordList({required this.number, super.key});

  List<BookinModel> number = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: number.map((e) => AdminRecordCard(numbers2: e)).toList(),
    );
  }
}

class AdminRecordCard extends StatelessWidget {
  AdminRecordCard({required this.numbers2, super.key});
  BookinModel numbers2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${numbers2.userId.username}"),
            Text("${numbers2.hairName}"),
            Text("${numbers2.stylistId.username}"),
            Text("N${numbers2.amount}"),
            Text("${numbers2.appointmentDate}"),
            if (numbers2.showStatus == 'paid')
              Container(
                width: 65,
                height: 22,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 136, 236, 139),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(100), bottom: Radius.circular(100)),
                ),
                child: Center(
                  child: Text(
                    "${numbers2.showStatus}",
                    style: TextStyle(
                        color: Color.fromARGB(255, 27, 120, 30), fontSize: 14),
                  ),
                ),
              ),
            if (numbers2.showStatus == "Pending")
              Container(
                width: 65,
                height: 22,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 237, 164, 164),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(100), bottom: Radius.circular(100)),
                ),
                child: Center(
                  child: Text(
                    "${numbers2.showStatus}",
                    style: TextStyle(
                        color: Color.fromARGB(255, 129, 29, 29), fontSize: 14),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
