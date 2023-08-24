import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';

Widget formCardFiled(
    {label,
    hintText,
    controller2,
    keybordtype1,
    change2,
    err,
    p3,
    onchange3,
    suffixIcon2,
    inputeformat1,
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
        inputFormatters: inputeformat1,
        obscureText: obscureText,
        onChanged: onchange3,
        decoration: InputDecoration(
            prefixIcon: p3,
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

class CardNumberInputForm extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String inputeData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputeData.length; i++) {
      buffer.write(inputeData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputeData.length != index) {
        buffer.write("  "); // double space
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.toString().length,
      ),
    );
  }
}

class CardMonthInputForm extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroindex = i + 1;

      if (nonZeroindex % 2 == 0 && nonZeroindex != newText.length) {
        buffer.write("/"); //
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
