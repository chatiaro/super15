import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/screens/DemoQuiz/QuizModel.dart';
import 'package:super15/screens/Login/widgets/action_button.dart';
import 'package:super15/screens/Login/widgets/inputComponent.dart';
import 'package:super15/screens/widgets/back_container.dart';
import 'package:super15/services/User.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

var userData;

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    userData = Provider.of<UserData>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 5.h,
          elevation: 0.0,
          flexibleSpace: _header(),
        ),
        body: backContainer(
            child: Column(
          children: [
            _profileHolder(),
            SizedBox(
              height: 20,
            ),
            _inputInfo("User Name", userData.name),
            _inputInfo("Email", userData.email),
            _inputInfo("Phone", userData.phone),
            Spacer(),
            actionButton(text: "Update", onClick: () {}),
            SizedBox(
              height: 20,
            )
          ],
        )),
      ),
    );
  }

  Widget _header() {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios_new)),
            Spacer(),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.close))
          ],
        ));
  }

  Widget _profileHolder() {
    return GestureDetector(
      onTap: () {},
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40, left: 20),
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
          Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Icon(Icons.edit_outlined))
        ],
      )),
    );
  }

  Widget _inputInfo(title, text, {controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
        ),
        Text(title),
        SizedBox(
          height: 5,
        ),
        inputComponent(text, controller: controller)
      ],
    );
  }
}
