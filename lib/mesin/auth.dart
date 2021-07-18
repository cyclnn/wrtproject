import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } on FirebaseAuthException {
      print('e.message');
    }
  }

  static Future signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  static Future forgotPass(String email) async {
    try {
      var result =
          _auth.sendPasswordResetEmail(email: email).then((value) => null);
      var user = result;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  static Future<void> signOut() async {
    final GoogleSignIn _google = GoogleSignIn();

    _auth.signOut();
    _google.signOut();
  }

  static Stream<User> get firebaseUserStream => _auth.authStateChanges();
}
