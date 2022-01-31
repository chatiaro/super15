import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/screens/Login/SignInPage.dart';
import 'package:super15/screens/Login/widgets/inputComponent.dart';
import 'package:super15/screens/widgets/back_container.dart';
import 'package:super15/screens/widgets/footer_text.dart';
import 'package:super15/values/UiColors.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: backContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/quizAppLogo.png",
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: Text(
                    "Forgot your password?",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  height: 60.sp,
                ),
                Container(
                  height: 200,
                  child: PageView(
                    controller: pageController,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reset using mobile",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13.sp),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            inputComponent(
                                "Enter your registered mobile number"),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text("You will get a OTP on this number.",
                                  style: GoogleFonts.nunito(fontSize: 12.sp)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              },
                              child: Center(
                                child: Text("Reset using email",
                                    style: GoogleFonts.nunito(
                                        fontSize: 12.sp,
                                        color: Color(0XFF666666))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reset using email",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13.sp),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            inputComponent("Enter your registered email id"),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text("You will get a OTP on this number.",
                                  style: GoogleFonts.nunito(fontSize: 12.sp)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              },
                              child: Center(
                                child: Text("Reset using mobile",
                                    style: GoogleFonts.nunito(
                                        fontSize: 12.sp,
                                        color: Color(0XFF666666))),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.sp,
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: UiColors.primary),
                    child: Center(
                      child: Text(
                        "RESET PASSWORD",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: Color(0XFFE5E5E5)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                footerText(
                    context: context,
                    text: "Wrong Screen? Go to",
                    btnText: "LOGIN",
                    newPage: SignInPage())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
