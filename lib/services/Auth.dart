import 'package:firebase_auth/firebase_auth.dart';
import 'User.dart' as account;

class Auth {
  static final _auth = FirebaseAuth.instance;
  static account.User _getUser(UserCredential user) {
    return user != null ? new account.User(user.user!.uid) : null!;
  }

  static Future<account.User> _loginEmailAndPass(email, password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _getUser(user);
    } catch (e) {}
    return null!;
  }
}
