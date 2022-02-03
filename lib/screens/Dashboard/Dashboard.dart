import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/screens/Dashboard/Rules.dart';
import 'package:super15/screens/DemoQuiz/QuizModel.dart';
import 'package:super15/screens/widgets/back_container.dart';
import 'package:super15/services/Prefs.dart';

import 'package:super15/services/User.dart';
import 'package:super15/values/UiColors.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.userId, this.data})
      : super(key: key);
  final userId;
  final data;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Query<Map<String, dynamic>> userData;
  late User user;
  String? uId;

  @override
  void initState() {
    super.initState();
    setUserId();
  }

  Future setUserId() async => Prefs.setUserId(widget.userId);

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final data = widget.data ?? Provider.of<UserData>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 10.h,
            elevation: 0.0,
            flexibleSpace: _header(data),
          ),
          body: backContainer(
              child: Column(
            children: [
              SizedBox(
                height: 20.sp,
              ),
              Expanded(flex: 3, child: _body(data)),
              Expanded(flex: 2, child: _footer(data))
            ],
          ))),
    );
  }

  Widget _header(data) {
    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(30)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: data.profilePhoto == "none"
                    ? Image.asset(
                        "assets/images/profile_pic.png",
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        data.profilePhoto.toString(),
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            RichText(
                text: TextSpan(
                    style: GoogleFonts.montserrat(color: Colors.black),
                    children: [
                  TextSpan(
                      text: "Hello, ",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: capitalize(data.name.toString()) == "Null"
                          ? "Loading..."
                          : capitalize(data.name.toString()),
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w600)),
                ])),
            const Spacer(),
            Image.asset(
              "assets/images/notifIcon.png",
              height: 15.sp,
            ),
            const SizedBox(
              width: 20,
            ),
            Icon(Icons.more_vert)
          ],
        ),
      ),
    );
  }

  Widget _body(data) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 120.sp,
            width: 100.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 216, 192, 255)),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 85,
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: UiColors.primary)),
            child: Center(
                child: Text(
              "PLAY QUIZ",
              style: TextStyle(fontSize: 12.sp, color: UiColors.primary),
            )),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Rules(
                            uId: widget.userId,
                          )));
            },
            child: Container(
              height: 85,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: UiColors.primary),
              child: Center(
                  child: Text(
                "PLAY DEMO",
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget _footer(data) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0XFFD4D4FF), Color(0XFF9999FF)],
              ),
            ),
            height: 85,
            child: Row(
              children: [
                Image.asset(
                  "assets/images/updateEmail.png",
                  height: 40,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Update Email Address",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 12.sp),
                    ),
                    Text(
                      data.email.toString() == "Null" ||
                              data.email.toString() == ""
                          ? "No email address found"
                          : data.email.toString(),
                      style: GoogleFonts.nunito(fontSize: 12.sp),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0XFFD4D4FF), Color(0XFF9999FF)],
              ),
            ),
            height: 85,
            child: Row(
              children: [
                Image.asset(
                  "assets/images/updatePassword.png",
                  height: 40,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Change Password",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 12.sp),
                    ),
                    Text(
                      "Last changed 2 weeks ago",
                      style: GoogleFonts.nunito(fontSize: 12.sp),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rules and Guidelines.",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Rules(
                                uId: widget.userId,
                              )));
                },
                child: Text(
                  "READ HERE",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      color: UiColors.primary),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
