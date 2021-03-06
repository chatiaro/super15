import 'package:firebase_auth/firebase_auth.dart';
import 'package:super15/services/Prefs.dart';
import 'User.dart' as account;

class Auth {
  static final _auth = FirebaseAuth.instance;
  static account.User _getUser(UserCredential user) {
    return user != null ? new account.User(user.user!.uid) : null!;
  }

  static Future loginEmailAndPass(email, password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await Prefs.setUserId(user.user!.uid);
    } catch (e) {}
    return null!;
  }

  static Future signOut() async {
    FirebaseAuth.instance.signOut();
    await Prefs.toggleIsLoggedIn();
  }
}
