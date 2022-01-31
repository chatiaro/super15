import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/values/UiColors.dart';

Widget footerText({context, text, btnText, newPage}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
      ),
      const SizedBox(
        width: 5,
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => newPage),
          );
        },
        child: Text(
          btnText,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
              color: UiColors.primary),
        ),
      )
    ],
  );
}
