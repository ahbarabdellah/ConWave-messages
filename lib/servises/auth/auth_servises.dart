import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServises extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebasestore = FirebaseFirestore.instance;

  Future<UserCredential> signinwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      _firebasestore.collection('users').doc(userCredential.user!.uid).set(
        {
          "userID": userCredential.user!.uid,
          "email": email,
        },
        SetOptions(
          merge: true,
        ),
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signout() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<UserCredential> signUpwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firebasestore.collection('users').doc(userCredential.user!.uid).set(
        {
          "userID": userCredential.user!.uid,
          "email": email,
        },
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
