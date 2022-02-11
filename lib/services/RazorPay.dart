import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

class RazorPay extends StatefulWidget {
  const RazorPay(
      {Key? key,
      required this.orderId,
      required this.title,
      required this.amount,
      required this.description,
      required this.name,
      required this.number,
      required this.email})
      : super(key: key);
  final orderId;
  final title;
  final amount;
  final name;
  final description;
  final number;
  final email;
  @override
  _RazorPayState createState() => _RazorPayState();
}

class _RazorPayState extends State<RazorPay> {
  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text("Redirecting to RazorPay"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openCheckout();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': "rzp_live_ILgsfZCZoFIKMb",
      'amount': widget.amount * 100,
      'name': widget.name,
      "timeout": "180",
      "theme.color": "#03be03",
      'description': widget.description,
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.of(context, rootNavigator: true).push(
        new CupertinoPageRoute<bool>(
            fullscreenDialog: false,
            builder: (BuildContext context) =>
                PaymentSuccess(name: "Chati", amount: widget.amount)));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.of(context, rootNavigator: true).push(
        new CupertinoPageRoute<bool>(
            fullscreenDialog: false,
            builder: (BuildContext context) => PaymentFailure(
                name: "Chati", amount: widget.amount.toString())));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}
}

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({Key? key, required this.name, required this.amount})
      : super(key: key);
  final name;
  final amount;

  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
              color: Color(0XFFE5E5E5).withOpacity(0.2),
              width: 100.w,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18),
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Color(0XFF2BAAEC),
                        fontSize: 16.sp,
                        fontFamily: "SF-Pro-Rounded-Light"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentFailure extends StatefulWidget {
  const PaymentFailure({Key? key, required this.amount, required this.name})
      : super(key: key);
  final name;
  final amount;

  @override
  _PaymentFailureState createState() => _PaymentFailureState();
}

class _PaymentFailureState extends State<PaymentFailure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
              color: Color(0XFFE5E5E5).withOpacity(0.2),
              width: 100.w,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "• Internet connection was interupted\n• Insuficient Credit ",
                    style: TextStyle(fontSize: 12.sp, color: Colors.red),
                  )
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18),
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Color(0XFF2BAAEC),
                        fontSize: 16.sp,
                        fontFamily: "SF-Pro-Rounded-Light"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
