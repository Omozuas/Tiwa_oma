import 'package:flutter/material.dart';

import '../utils/global.colors.dart';
import 'addButtons.widgets.dart';

class AddButtonList extends StatelessWidget {
  const AddButtonList(
      {required this.categoryButton,
      super.key,
      this.addReview,
      this.reviewAdded});
  final List<Button> categoryButton;
  final int _currentSelection = 1;
  final bool? reviewAdded; // Pass the _reviewAdded state
  final void Function()? addReview; // Pass the _addReview function

  @override
  Widget build(BuildContext context) {
    return Column(
      children: categoryButton
          .map((e) => AddButtonCard(
                buttonAdd: e,
                reviewAdded: reviewAdded, // Pass the _reviewAdded state
                addReview: () {
                  if (addReview != null) {
                    addReview!();
                  }
                },
                currentSelection:
                    _currentSelection, // Pass the _addReview function
              ))
          .toList(),
    );
  }
}

class AddButtonCard extends StatelessWidget {
  const AddButtonCard(
      {required this.buttonAdd,
      required this.addReview,
      super.key,
      this.reviewAdded,
      required this.currentSelection});
  final int currentSelection;
  final Button buttonAdd;
  final bool? reviewAdded; // Use the passed _reviewAdded state

  // Track if "Add Review" button is clicked
  final void Function() addReview;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          if (!(reviewAdded ?? false))
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Icon(
                    Icons.add_box_outlined,
                    size: 28,
                    color: GlobalColors.blue,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  InkWell(
                      onTap: () {
                        addReview();
                      },
                      child: Text(
                        "Add Review",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: GlobalColors.blue),
                      )),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            )
        ]),
      ),
    );
  }
}
