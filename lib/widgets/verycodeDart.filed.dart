
// import 'package:flutter/material.dart';
// import 'package:Tiwa_Omas/utils/global.colors.dart';

// Widget textFieldOpt({required bool first, last}) {
//   return SizedBox(
//       height: 85,
//       child: AspectRatio(
//         aspectRatio: 0.5,
//         child: TextField(
//           autofocus: true,
//           onChanged: (value) {
//             if (value.length == 1 && last == false) {
//               FocusScope.of(context ).nextFocus();
//             }
//             if (value.length == 1 && first == false) {
//               FocusScope.of(context ).previousFocus();
//             }
//           },
//           showCursor: false,
//           readOnly: false,
//           textAlign: TextAlign.center,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//           keyboardType: TextInputType.number,
//           maxLength: 1,
//           decoration: InputDecoration(
//               counter: Offstage(),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(width: 2, color: GlobalColors.gray)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(width: 2, color: GlobalColors.green))),
//         ),
//       ));
// }
