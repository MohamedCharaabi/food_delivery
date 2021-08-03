import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:food_delivery_flutter/pages/Signin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  String? uid;
  String? name;
  String? userEmail;
  String? imageUrl;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//To check is User is logged in
  bool isLoggedIn() {
    User? user = _auth.currentUser;
    if (user == null) {
      return false;
    }
    return user.emailVerified;
  }

//google sign in
  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<bool?> signUpwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignUpAccount =
          await _googleSignIn.signIn();

      Map<String, dynamic> userData = {
        "username": googleSignUpAccount?.displayName ?? '',
        "email": googleSignUpAccount?.email ?? null,
        "phone": null,
        "password": null,
        "auth_method": "google"
      };
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignUpAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      log('userData ==W> $userData');
      await _auth
          .signInWithCredential(credential)
          .then((result) async => await addUser(userData, result.user!.uid));
      return true;
      // await addUser(userData, userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      // return false;
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

// signin with email and password
  Future<void> registerWithEmailPassword(Map<String, dynamic> formData) async {
    // await Firebase.initializeApp();

    try {
      // User user = (
      await _auth
          .createUserWithEmailAndPassword(
            email: formData['email'],
            password: formData['password'],
          )
          .then((result) async => {
                await result.user!.sendEmailVerification(),
                await addUser(formData, result.user!.uid)
              });
      // )
      //     .user!;

      // log('User created: ' + user.uid);

      // if (user != null) {
      //   uid = user.uid;
      //   userEmail = user.email;
      // }
      // return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<bool?> signInWithEmailPassword(String email, String password) async {
    await Firebase.initializeApp();
    User? user;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      log('user ==> $user');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return isLoggedIn();
  }

  Future<String> signOut() async {
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);

    uid = null;
    userEmail = null;

    return 'User signed out';
  }

//Signin with Facebook
  Future<Resource?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
              FacebookAuthProvider.credential(result.accessToken!.token);

          final userCredential =
              await _auth.signInWithCredential(facebookCredential);

          Map<String, dynamic> userData = {
            "username": userCredential.user!.displayName,
            "email": userCredential.user!.email ?? null,
            "phone": null,
            "password": null,
            "auth_method": "facebook"
          };

          await addUser(userData, userCredential.user!.uid);

          return Resource(status: Status.Success);
        case LoginStatus.cancelled:
          return Resource(status: Status.Cancelled);
        case LoginStatus.failed:
          return Resource(status: Status.Error);
        default:
          return null;
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

//Firestore crud
  Future<void> addUser(Map<String, dynamic> userData, String uuid) async {
    final CollectionReference _mainCollection = _firestore.collection('users');

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .set(userData);
  }
}
