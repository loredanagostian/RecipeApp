import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/managers/google_manager.dart';
import 'package:first_app/managers/authentication_manager.dart';
import 'package:first_app/screens/main_screen.dart';
import 'package:first_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  runApp(MyApp(sharedPrefs: sharedPrefs));
}

class MyApp extends StatelessWidget {
  SharedPreferences sharedPrefs;
  MyApp({required this.sharedPrefs});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthenticationManager().isLoggedIn(sharedPrefs)
              ? MainScreen()
              : LoginScreen(),
          routes: {
            'loginRoute': (context) => LoginScreen(),
            'signUpRoute': (context) => SignUpScreen(),
            'mainRoute': (context) => MainScreen(),
          },
        ),
      );
}
