import 'package:first_app/managers/authentication_manager.dart';
import 'package:first_app/screens/main_screen.dart';
import 'package:first_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  String _email = "";
  String _pass = "";

  @override
  Widget build(BuildContext context) {
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
                        color: Color.fromARGB(255, 33, 18, 13),
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
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        'assets/icons/checkbox.png',
                        height: 25,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35.0),
                //password field
                TextField(
                  onChanged: (value) {
                    _pass = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 33, 18, 13),
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
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        'assets/icons/hidden.png',
                        height: 25,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _isChecked,
                      activeColor: const Color.fromARGB(255, 255, 117, 108),
                      onChanged: (value) {
                        _isChecked = !_isChecked;
                        setState(() {});
                      },
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                    ),
                  },
                  child: InkWell(
                    onTap: () {
                      bool isValid = validateFields();
                      if (isValid) {
                        Navigator.pushNamed(context, 'mainRoute');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 18, 13),
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
                ),
                const SizedBox(height: 30),
                const Text('Or login with'),
                const SizedBox(height: 10),
                IconButton(
                  icon: Image.asset('assets/icons/google.png'),
                  iconSize: 50,
                  onPressed: () {},
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
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shadowColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 117, 108),
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

  void authenticateUser() {
    AuthenticationManager authManager = AuthenticationManager();
    authManager.logInUser(_email, _pass);
  }

  bool validateFields() {
    if (_email.isNotEmpty && _pass.isNotEmpty) {
      authenticateUser();
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email and password cannot be blank.')));
    }
    return false;
  }
}
