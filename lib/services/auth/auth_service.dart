import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //signin
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //save the user
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }

  //signup

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      //create a new user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      //save the user
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "email": email,
        "uid": userCredential.user!.uid,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }

  //signout

  Future<void> signOut() async {
    await _auth.signOut();
  }

  //error
}
