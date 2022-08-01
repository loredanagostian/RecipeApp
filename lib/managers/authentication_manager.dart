import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationManager {
  Future<void> logInUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null && credential.user!.email != null) {
        saveUserData(credential.user!.email!);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signUpUser(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null && credential.user!.email != null) {
        saveUserData(credential.user!.email!);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  void saveUserData(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userEmail', email);
  }

  bool isLoggedIn(SharedPreferences sharedPref) {
    return sharedPref.getString('userEmail') != null;
  }
}
