import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/managers/google_manager.dart';
import 'package:first_app/managers/authentication_manager.dart';
import 'package:first_app/screens/main_screen.dart';
import 'package:first_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _pass = "";
  bool _obscureText = true;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/cooking.jpg',
                  height: 70,
                  width: 70,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 13),
                const Text(
                  'Use your credentials below and login to your account',
                  style: TextStyle(
                    color: Color.fromARGB(255, 135, 135, 135),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 40.0),

                //email field
                TextField(
                  onChanged: (value) {
                    _email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 80, 202, 213),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 35.0),

                //password field
                TextField(
                  onChanged: (value) {
                    _pass = value;
                  },
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 80, 202, 213),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    bool isValid = await validateFields();
                    if (isValid) {
                      Navigator.pushNamed(context, 'mainRoute');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 209, 110, 252),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign me in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Or login with'),
                const SizedBox(height: 10),
                //google button
                IconButton(
                  icon: Image.asset('assets/icons/google.png'),
                  iconSize: 50,
                  onPressed: () async {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    try {
                      // Attempt to sign in the user in with Google
                      await provider.googleLogin();
                      signInWithGoogle(context);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'sign_in_canceled') {
                        return;
                      }
                    }
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 80, 202, 213),
                        shadowColor: Colors.white,
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> validateFields() async {
    AuthenticationManager authManager = AuthenticationManager();
    String message = '';

    if (_email.isNotEmpty || _pass.isNotEmpty) {
      message = await authManager.logInUser(_email, _pass);
      if (message == '') {
        return true;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email or password fields are empty')));
    }

    return false;
  }

  void signInWithGoogle(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainScreen()));
  }
}
