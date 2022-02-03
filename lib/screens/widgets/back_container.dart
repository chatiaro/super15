import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget backContainer({required Widget child, isPadding = true}) {
  return Container(
    height: 100.h,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Colors.white, Color.fromARGB(255, 216, 192, 255)],
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: isPadding ? 20 : 0),
    child: child,
  );
}
