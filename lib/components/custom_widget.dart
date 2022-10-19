// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_scale/themes/color.dart';

Widget submitBtn(
  Function() onPress,
  String textBtn, {
  Color? color,
  Color? textColor,
}) {
  return SizedBox(
    width: double.infinity,
    height: 40,
    child: ElevatedButton(
      onPressed: onPress,
      child: Text(
        textBtn,
        style: TextStyle(color: textColor),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
    ),
  );
}

Widget inputFieldwidget(BuildContext context, Icon icon, String hintText, Function onValidate, Function onSaved,
    {String initialValue = "",
    bool autoFocus = false,
    bool obscureText = false,
    int maxlenght = 30,
    var keyboardType = TextInputType.text,
    var maxline}) {
  return TextFormField(
    autofocus: autoFocus,
    obscureText: obscureText,
    initialValue: initialValue,
    maxLength: maxlenght,
    keyboardType: keyboardType,
    maxLines: maxline,
    onSaved: (value) {
      onSaved(value);
    },
    validator: (value) {
      return onValidate(value.toString().trim());
    },
    decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: secondary_text, fontSize: 14),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        errorStyle: TextStyle(fontSize: 14, color: error),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: primary,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: primary_dark,
            width: 1,
          ),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconTheme(
            child: icon,
            data: IconThemeData(color: primary),
          ),
        )),
  );
}
