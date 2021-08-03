import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/pages/Home.dart';
import 'package:food_delivery_flutter/pages/auth/login1.dart';
import 'package:food_delivery_flutter/pages/auth/signup1.dart';
import 'package:food_delivery_flutter/pages/authDialog.dart';
import 'package:food_delivery_flutter/services/firebase_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  User? _currentUser = FirebaseAuth.instance.currentUser;
  bool _emailVerification =
      _currentUser != null ? _currentUser.emailVerified : false;
  log('current user ==> $_currentUser');
  log('email verif ==> $_emailVerification');
  // bool l = signInWithEmailPassword(email, password)

  Widget child = FirebaseService().isLoggedIn() ? Home() : SignUpPage();

  runApp(MyApp(homePage: child));
}

class MyApp extends StatelessWidget {
  final Widget? homePage;
  MyApp({this.homePage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      home: homePage,
    );
  }
}
