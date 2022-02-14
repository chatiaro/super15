// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/values/UiColors.dart';

Widget inputComponent(text,
    {controller,
    keyboardType = TextInputType.text,
    obscureText = false,
    half = false}) {
  return Container(
    width: half ? 45.w : 100.w,
    margin: EdgeInsets.only(bottom: 10),
    child: TextField(
      controller: controller ?? new TextEditingController(),
      keyboardType: keyboardType,
      obscureText: obscureText,
      enableSuggestions: !obscureText,
      autocorrect: !obscureText,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: UiColors.teal),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: UiColors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: UiColors.teal),
        ),
        filled: true,
        contentPadding: EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    ),
  );
}
