import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/values/UiColors.dart';

Widget actionButton({required text, required Function onClick}) {
  return GestureDetector(
      onTap: () async {
        onClick();
      },
      child: Container(
        width: 100.w,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
            color: UiColors.primary, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: Colors.white),
          ),
        ),
      ));
}
