import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';

Widget RatingFiled(
    {label,
    hintText,
    controller2,
    keybordtype1,
    change2,
    err,
    suffixIcon2,
    obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: GlobalColors.gray),
      ),
      const SizedBox(height: 5),
      TextField(
        keyboardType: keybordtype1,
        controller: controller2,
        obscureText: obscureText,
        decoration: InputDecoration(
            suffixIcon: suffixIcon2,
            errorText: err,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 100,
            ),
            hintText: hintText,
            helperStyle: TextStyle(
                color: GlobalColors.gray,
                fontSize: 14,
                fontWeight: FontWeight.w400),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: GlobalColors.gray,
                ),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(12))),
      ),
    ],
  );
}
