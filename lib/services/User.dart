// ignore_for_file: null_check_always_fails

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User(this.uid) {
    userData = FirebaseFirestore.instance
        .collection('users')
        .where("userId", isEqualTo: uid);    
  }
  final uid;
  late Query<Map<String, dynamic>> userData;
  UserData getUserData(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot != null
        ? UserData(
            name: (snapshot.docs[0]["name"]),
            email: (snapshot.docs[0]["email"]),
            phone: (snapshot.docs[0]["phone"]),
            profilePhoto: (snapshot.docs[0]["profilePhoto"]))
        : null!;
  }

  Stream<UserData> get userInfo {
    return userData.snapshots().map(getUserData);
  }
}

class UserData {
  const UserData({this.name, this.email, this.phone, this.profilePhoto});
  final name;
  final email;
  final phone;
  final profilePhoto;
}
