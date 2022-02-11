// ignore_for_file: null_check_always_fails

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User(this.uid);
  final uid;
  late Query<Map<String, dynamic>> userData;
  UserData getUserData(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot != null
        ? UserData(
            name: (snapshot.docs[0]["name"]),
            email: (snapshot.docs[0]["email"]),
            phone: (snapshot.docs[0]["phone"]),
            points: (snapshot.docs[0]["points"]),
            profilePhoto: (snapshot.docs[0]["profilePhoto"]))
        : null!;
  }

  Stream<UserData> get userInfo {
    userData = FirebaseFirestore.instance
        .collection('users')
        .where("userId", isEqualTo: uid);
    return userData.snapshots().map(getUserData);
  }

  List<UserData> getUserList(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
          name: (doc.data()["name"]),
          email: (doc.data()["email"]),
          phone: (doc.data()["phone"]),
          points: (doc.data()["points"]),
          profilePhoto: (doc.data()["profilePhoto"]));
    }).toList();
  }

  Stream<List<UserData>> get userList {
    userData = FirebaseFirestore.instance
        .collection('users')
        .orderBy('points', descending: true);

    return userData.snapshots().map(getUserList);
  }

  Future<void> addPoint(int val) async {
    CollectionReference userData =
        FirebaseFirestore.instance.collection('users');
        

    await userData.doc(uid).update({"points": val});
  }
}

class UserData {
  const UserData(
      {this.name,
      this.email,
      this.phone,
      this.profilePhoto,
      this.points,
      this.uId});
  final name;
  final email;
  final phone;
  final profilePhoto;
  final points;
  final uId;
}
