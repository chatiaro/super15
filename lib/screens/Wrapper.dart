import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super15/screens/Dashboard/Dashboard.dart';
import 'package:super15/screens/Login/SignUpPage.dart';
import 'package:super15/services/Auth.dart';
import 'package:super15/services/Prefs.dart';
import 'package:super15/services/User.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late Map<String, dynamic> userData;
  bool isLoading = true;
  Future getUserData() async {
    await Prefs.getUserData().then((value) {
      userData = {"userId": value["userId"], "isLoggedIn": value["isLoggedIn"]};
    });
  }

  @override
  void initState() {
    getUserData().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : StreamProvider<UserData>.value(
            value: User(userData["userId"]).userInfo,
            initialData: new UserData(),
            child: userData["isLoggedIn"] ? SignupPage() : Dashboard(),
          );
  }
}