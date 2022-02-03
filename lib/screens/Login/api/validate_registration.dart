import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super15/services/Prefs.dart';

class ValidateRegistration {
  static Future<void> createAccount(
      {required CollectionReference userData,
      DocumentSnapshot? documentSnapshot,
      name,
      email,
      password,
      mobile,
      userId}) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
    }

    if (name != null) {
      if (action == 'create') {
        await userData.doc(userId).set({
          "name": name,
          "email": email,
          "password": password,
          "phone": mobile,
          "userId": userId,
          "profilePhoto": "none",
          "points": 0
        }).then((value) async {
          await Prefs.setLoginInfo(userId);
        });
      }

      if (action == 'update') {
        await userData.doc(documentSnapshot!.id).update({
          "name": name,
          "email": email,
          "password": password,
          "phone": mobile
        }).then((value) async {});
      }
    }
  }

  static bool validateFields(name, email, password, mobile) {
    return true;
  }
}
