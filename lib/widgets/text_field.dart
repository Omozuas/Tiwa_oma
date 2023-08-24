import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';

Widget textFiled(
    {label,
    hintText,
    err,
    controller2,
    suffixIcon2,
    keyboardType4,
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
        controller: controller2,
        keyboardType: keyboardType4,
        obscureText: obscureText,
        decoration: InputDecoration(
            suffixIcon: suffixIcon2,
            errorText: err,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            hintText: hintText,
            helperStyle: TextStyle(
                color: GlobalColors.gray,
                fontSize: 14,
                fontWeight: FontWeight.w400),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: GlobalColors.gray),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10))),
      ),
      const SizedBox(
        height: 30,
      ),
    ],
  );
}
