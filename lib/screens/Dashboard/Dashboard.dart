import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/screens/Dashboard/AddQuiz.dart';
import 'package:super15/screens/Dashboard/EditProfile.dart';
import 'package:super15/screens/Dashboard/Rules.dart';

import 'package:super15/screens/Login/SignUpPage.dart';
import 'package:super15/screens/widgets/back_container.dart';
import 'package:super15/services/Auth.dart';
import 'package:super15/services/Prefs.dart';
import 'package:super15/services/RazorPay.dart';

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
    final userList = Provider.of<List<UserData>>(context);
    return SafeArea(
      child: data.isAdmin == null
          ? Scaffold(
              body: Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: UiColors.primary,
                  ),
                ),
              ),
            )
          : Scaffold(
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
                  Expanded(flex: 3, child: _body(data, userList)),
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
            data.isAdmin ?? false
                ? PopupMenuButton(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Icon(Icons.more_vert),
                    ),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Sign Out"),
                            value: 1,
                            onTap: () async {
                              await Auth.signOut().then((value) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()),
                                    (Route<dynamic> route) => false);
                              });
                            },
                          ),
                          PopupMenuItem(
                            child: Text("Edit Profile"),
                            value: 2,
                            onTap: () async {
                              await Future.delayed(Duration(microseconds: 1))
                                  .then((value) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MultiProvider(
                                    providers: [
                                      StreamProvider<UserData>.value(
                                        value: User(widget.userId).userInfo,
                                        initialData: new UserData(),
                                      ),
                                    ],
                                    child: EditProfile(),
                                  ),
                                ));
                              });
                            },
                          ),
                          PopupMenuItem(
                            child: Text("Edit Profile"),
                            value: 2,
                            onTap: () async {
                              await Future.delayed(Duration(microseconds: 1))
                                  .then((value) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MultiProvider(
                                    providers: [
                                      StreamProvider<UserData>.value(
                                        value: User(widget.userId).userInfo,
                                        initialData: new UserData(),
                                      ),
                                    ],
                                    child: EditProfile(),
                                  ),
                                ));
                              });
                            },
                          )
                        ])
                : PopupMenuButton(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Icon(Icons.more_vert),
                    ),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Sign Out"),
                            value: 1,
                            onTap: () async {
                              await Auth.signOut().then((value) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()),
                                    (Route<dynamic> route) => false);
                              });
                            },
                          ),
                          PopupMenuItem(
                            child: Text("Edit Profile"),
                            value: 2,
                            onTap: () async {
                              await Future.delayed(Duration(microseconds: 1))
                                  .then((value) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MultiProvider(
                                    providers: [
                                      StreamProvider<UserData>.value(
                                        value: User(widget.userId).userInfo,
                                        initialData: new UserData(),
                                      ),
                                    ],
                                    child: EditProfile(),
                                  ),
                                ));
                              });
                            },
                          ),
                          PopupMenuItem(
                            child: Text("Add Quiz for Tommorow"),
                            value: 3,
                            onTap: () async {
                              await Future.delayed(Duration(microseconds: 1))
                                  .then((value) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MultiProvider(
                                    providers: [
                                      StreamProvider<UserData>.value(
                                        value: User(widget.userId).userInfo,
                                        initialData: new UserData(),
                                      ),
                                    ],
                                    child: AddQuiz(),
                                  ),
                                ));
                              });
                            },
                          )
                        ])
          ],
        ),
      ),
    );
  }

  Widget _body(data, userList) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 120.sp,
            width: 100.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 216, 192, 255)),
            child: _leaderBoard(userList),
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RazorPay(
                          orderId: "orderId",
                          title: "Super15",
                          amount: 200,
                          description: "Participate in paid quiz",
                          name: data.name,
                          number: data.phone,
                          email: data.email)));
            },
            child: Container(
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

  Widget _leaderBoard(userList) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        children: [
          Center(
              child: Text(
            "Leaderboard",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          )),
          Expanded(
              child: ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(30)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: userList[index].profilePhoto == "none"
                                    ? Image.asset(
                                        "assets/images/profile_pic.png",
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        userList[index].profilePhoto.toString(),
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              userList[index].name,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                              ),
                            ),
                            Spacer(),
                            Text(
                              userList[index].points.toString(),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  color: Colors.black54),
                            )
                          ],
                        ));
                  }))
        ],
      ),
    );
  }

  Widget _footer(data) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MultiProvider(
                  providers: [
                    StreamProvider<UserData>.value(
                      value: User(widget.userId).userInfo,
                      initialData: new UserData(),
                    ),
                  ],
                  child: EditProfile(),
                ),
              ));
            },
            child: Container(
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
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Fluttertoast.showToast(msg: "Coming Soon");
            },
            child: Container(
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
                        "Last changed recently",
                        style: GoogleFonts.nunito(fontSize: 12.sp),
                      ),
                    ],
                  )
                ],
              ),
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
