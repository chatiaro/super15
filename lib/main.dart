import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:super15/screens/Dashboard/Dashboard.dart';
import 'package:super15/screens/Login/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:super15/screens/Wrapper.dart';
import 'package:super15/services/Auth.dart';
import 'services/User.dart' as account;
import 'package:super15/services/Prefs.dart';
import 'package:super15/services/User.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Super15());
}

class Super15 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: (const Wrapper()),
      );
    });
  }
}
