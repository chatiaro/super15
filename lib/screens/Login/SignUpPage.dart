// ignore_for_file: unused_field, unnecessary_new, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/screens/Dashboard/Dashboard.dart';
import 'package:super15/screens/Login/SignInPage.dart';
import 'package:super15/screens/Login/api/validate_registration.dart';
import 'package:super15/screens/Login/widgets/inputComponent.dart';
import 'package:super15/screens/Login/widgets/action_button.dart';
import 'package:super15/screens/widgets/back_container.dart';
import 'package:super15/screens/widgets/footer_text.dart';
import 'package:super15/services/User.dart';
import 'package:super15/values/UiColors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;
  final CollectionReference userData =
      FirebaseFirestore.instance.collection('users');

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _mobileController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserData>(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: backContainer(
              child: Column(
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
          Text(
            "Register on Super15",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
          const SizedBox(
            height: 35,
          ),
          inputComponent("Name", controller: _nameController),
          inputComponent("Mobile", controller: _mobileController),
          inputComponent("Email", controller: _emailController),
          inputComponent("Password", controller: _passwordController),
          isLoading
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SpinKitThreeBounce(
                    color: UiColors.primary,
                    size: 20.sp,
                  ),
                )
              : actionButton(
                  text: "REGISTER",
                  onClick: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);
                      if (newUser != null) {
                        setState(() {
                          ValidateRegistration.createAccount(
                                  userData: userData,
                                  name: _nameController.text,
                                  mobile: _mobileController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  userId: newUser.user!.uid)
                              .then((value) {
                            isLoading = false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard(
                                          data: data,
                                          userId: newUser.user!.uid,
                                        )));
                          });
                        });
                      }
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }),
          const SizedBox(
            height: 45,
          ),
          footerText(
              context: context,
              text: "Already have an account?",
              btnText: "LOGIN",
              newPage: const SignInPage())
        ],
      ))),
    ));
  }
}
