import 'package:email_validator/email_validator.dart';
import 'package:first_app/managers/authentication_manager.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email = "";
  String _pass = "";
  String _repeated = "";
  final formKey = GlobalKey<FormState>();

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
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/sign-up.png',
                    height: 80,
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                    validator: (value) =>
                        value!.isEmpty || !EmailValidator.validate(value)
                            ? 'Please enter a valid email address.'
                            : null,
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
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _pass = value.trim();
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Please enter at least 8 characters.';
                      }
                      return null;
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
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _repeated = value.trim();
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Please enter at least 8 characters.';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
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
                    ),
                  ),
                  const SizedBox(height: 35),
                  InkWell(
                    onTap: () => {_submit()},
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 18, 13),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign me up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUpUser() {
    AuthenticationManager authManager = AuthenticationManager();
    authManager.signUpUser(_email, _pass);
  }

  bool validateFields() {
    print(_email);
    print(_pass);
    print(_repeated);
    print(_email);
    if (_email.isNotEmpty &&
        _pass.isNotEmpty &&
        _repeated.isNotEmpty &&
        _pass == _repeated) {
      signUpUser();
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Entries did not match.')));
    }
    return false;
  }

  void _submit() {
    bool isValid = formKey.currentState!.validate();
    if (isValid && validateFields()) {
      formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      Navigator.pushNamed(context, 'mainRoute');
    }
    return;
  }
}
