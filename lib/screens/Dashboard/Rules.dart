import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/screens/widgets/back_container.dart';
import 'package:super15/values/UiColors.dart';

class Rules extends StatefulWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: backContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_header(), _body(), const Spacer(), _footer()],
          ),
        ),
      ),
    ));
  }

  Widget _header() {
    return Container(
      child: Row(
        children: [
          const Icon(Icons.arrow_back_ios),
          const SizedBox(
            width: 30,
          ),
          Text(
            "Super15 Rules",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
          ),
          const Spacer(),
          Icon(
            Icons.more_vert,
            size: 20.sp,
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.only(top: 35, left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Brief explanation about this quiz",
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 75,
            width: 100.w,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 7,
                      spreadRadius: -3,
                      color: Colors.black12)
                ]),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/rules.png",
                  height: 30.sp,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "15 Questions or 11 Questions?",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 12.sp),
                    ),
                    const Spacer(),
                    Text(
                      "Understanding the twist.",
                      style: GoogleFonts.nunito(
                          color: Color(0XFF999999), fontSize: 10.sp),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 75,
            width: 100.w,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 7,
                      spreadRadius: -3,
                      color: Colors.black12)
                ]),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/rules_2.png",
                  height: 30.sp,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "8 hours 1 min 30 sec",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 12.sp),
                    ),
                    const Spacer(),
                    Text(
                      "Total duration of the quiz. Read more.",
                      style: GoogleFonts.nunito(
                          color: Color(0XFF999999), fontSize: 10.sp),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            "Please read the text below carefully so you can understand it",
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
          ),
          _bulletPoint(
              "Answer each question within the given time to continue."),
          _bulletPoint("Tap on options to select the correct answer"),
          _bulletPoint(
              "Click submit if you are sure you want to submit the answer. "),
          _bulletPoint(
              "Once submitted your answer cannot be changed even if there is time left."),
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      width: 100.w,
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: UiColors.primary),
      child: Center(
        child: Text(
          "Get Started",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
              color: Colors.white),
        ),
      ),
    );
  }

  Widget _bulletPoint(text) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.black),
            height: 7,
            width: 7,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              text,
              style:
                  GoogleFonts.nunito(color: Color(0XFF666666), fontSize: 12.sp),
            ),
          )
        ],
      ),
    );
  }
}
