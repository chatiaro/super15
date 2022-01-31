// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:super15/values/UiColors.dart';

Widget inputComponent(text, {controller}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    child: TextField(
      controller: controller ?? new TextEditingController(),
      keyboardType: TextInputType.text,
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
