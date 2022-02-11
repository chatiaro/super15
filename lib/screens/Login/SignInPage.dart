// ignore_for_file: unnecessary_new, unused_field, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/screens/Dashboard/Dashboard.dart';
import 'package:super15/screens/Login/ForgotPass.dart';
import 'package:super15/screens/Login/SignUpPage.dart';
import 'package:super15/screens/Login/widgets/action_button.dart';
import 'package:super15/screens/Login/widgets/inputComponent.dart';
import 'package:super15/screens/widgets/back_container.dart';
import 'package:super15/screens/widgets/footer_text.dart';
import 'package:super15/services/Auth.dart';
import 'package:super15/services/Prefs.dart';
import 'package:super15/values/UiColors.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Wrapper.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // text fields' controllers
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final CollectionReference userData =
      FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    super.initState();
  }

  bool isLogging = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: userData.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return backContainer(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/quizAppLogo.png",
                        height: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      "Login on Super15",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16.sp),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    inputComponent("Email", controller: _emailController),
                    inputComponent("Password", controller: _passwordController),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPass()));
                        },
                        child: Text(
                          "Forgot Password",
                          style: GoogleFonts.nunito(
                              fontSize: 12.sp, color: Colors.black45),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    isLogging
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: SpinKitThreeBounce(
                              color: UiColors.primary,
                              size: 20.sp,
                            ),
                          )
                        : actionButton(
                            text: "LOGIN",
                            onClick: () async {
                              try {
                                setState(() {
                                  isLogging = true;
                                });
                                var user = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text);
                                if (user != null) {
                                  setState(() {
                                    isLogging = false;
                                  });
                                  await Prefs.toggleIsLoggedIn();
                                  await Prefs.setUserId(user.user!.uid);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => Wrapper()),
                                      (Route<dynamic> route) => false);
                                } else {
                                  setState(() {
                                    isLogging = false;
                                  });
                                }
                              } catch (e) {
                                setState(() {
                                  isLogging = false;
                                });
                                Fluttertoast.showToast(msg: e.toString());
                              }
                            }),
                    const SizedBox(
                      height: 45,
                    ),
                    footerText(
                        context: context,
                        text: "Don't have an account?",
                        btnText: "REGISTER",
                        newPage: SignupPage())
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
