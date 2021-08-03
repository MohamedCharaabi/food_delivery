import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

String? uid;
String? name;
String? userEmail;
String? imageUrl;

Future<bool> checkAuth() async {
  SharedPreferences userIsAuthenticated = await SharedPreferences.getInstance();

  return userIsAuthenticated.getBool('auth') ?? false;
}

/// For checking if the user is already signed into the
/// app using Google Sign In
Future getUser() async {
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool authSignedIn = prefs.getBool('auth') ?? false;

  final User? user = _auth.currentUser;

  if (authSignedIn == true) {
    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;
    }
  }
}

Future<User?> registerWithEmailPassword(String email, String password) async {
  // await Firebase.initializeApp();

  try {
    User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user!;

    log('User created: ' + user.uid);

    // if (user != null) {
    //   uid = user.uid;
    //   userEmail = user.email;
    // }
    return user;
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

Future<User?> signInWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();
  User? user;
  log('email ==> $email \n password ==> $password');
  try {
    log('TRY');

    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;

    log('userCredentials ==> ');
    log('user ==> $user');

    // if (user != null) {
    //   uid = user.uid;
    //   userEmail = user.email;

    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   await prefs.setBool('auth', true);
    // }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
    }
  }

  return user;
}

Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;

  return 'User signed out';
}
