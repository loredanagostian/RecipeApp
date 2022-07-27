import 'package:first_app/screens/main_screen.dart';
import 'package:first_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'loginRoute',
      routes: {
        'loginRoute': (context) => LoginScreen(),
        'signUpRoute': (context) => SignUpScreen(),
        'mainRoute': (context) => MainScreen(),
      },
    );
  }
}
