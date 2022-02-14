import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/screens/Dashboard/Dashboard.dart';
import 'package:super15/screens/Login/widgets/action_button.dart';
import 'package:super15/screens/Wrapper.dart';
import 'package:super15/screens/widgets/back_container.dart';
import 'package:super15/services/Prefs.dart';
import 'package:super15/services/User.dart';
import 'package:super15/values/UiColors.dart';
import 'package:share_plus/share_plus.dart';

class QuizResult extends StatefulWidget {
  const QuizResult({Key? key}) : super(key: key);

  @override
  _QuizResultState createState() => _QuizResultState();
}

var userData;
var userList;

class _QuizResultState extends State<QuizResult> {
  String userId = "";
  Future getUserId() async {
    userId = await Prefs.setUserId(userId);
  }

  @override
  Widget build(BuildContext context) {
    userData = Provider.of<UserData>(context);
    userList = Provider.of<List<UserData>>(context);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 5.h,
            elevation: 0.0,
            flexibleSpace: _header(),
          ),
          body: backContainer(
              child: Container(
            child: Column(
              children: [
                _profileHolder(),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: AutoSizeText(
                    (userList[0].uId == userData.uId ||
                            userList[1].uId == userData.uId ||
                            userList[3].uId == userData.uId)
                        ? "Congrats!"
                        : "Better Luck Next Time",
                    maxLines: 1,
                    style: GoogleFonts.montserrat(
                        fontSize: 25.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                      child: Column(
                        children: [
                          Center(
                              child: Text(
                            "Leaderboard",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          )),
                          Container(
                            margin: EdgeInsets.only(
                                top: 10, left: 40, right: 40, bottom: 10),
                            height: 2,
                            color: Colors.black38,
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: userList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.black12,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(32),
                                                child: userList[index]
                                                            .profilePhoto ==
                                                        "none"
                                                    ? Image.asset(
                                                        "assets/images/profile_pic.png",
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.network(
                                                        userData[index]
                                                            .profilePhoto
                                                            .toString(),
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
                                  })),
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: actionButton(
                                  text: "Share",
                                  onClick: () {
                                    Share.share(
                                        "Checkout my awesome score on Super15!");
                                  })),
                        ],
                      ),
                    )),
              ],
            ),
          ))),
    );
  }

  Widget _header() {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios_new),
            Spacer(),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Wrapper()),
                      (route) => false);
                },
                child: Icon(Icons.home))
          ],
        ));
  }

  Widget _profileHolder() {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: RadialGradient(
                  center: Alignment.center,
                  colors: [UiColors.primary, Colors.white])),
          child: Container(
            margin: EdgeInsets.only(top: 0, left: 0),
            height: 140.sp,
            width: 140.sp,
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(100)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(62),
              child: userData.profilePhoto == "none"
                  ? Image.asset(
                      "assets/images/profile_pic.png",
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      userData.profilePhoto.toString(),
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
