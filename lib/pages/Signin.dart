import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery_flutter/pages/Home.dart';
import 'package:food_delivery_flutter/services/firebase_services.dart';

class SigninButton extends StatefulWidget {
  final FaIcon faIcon;
  final LoginType loginType;
  final textLabel;

  const SigninButton(
      {Key? key,
      required this.faIcon,
      required this.loginType,
      required this.textLabel})
      : super(key: key);

  @override
  _SigninButtonState createState() => _SigninButtonState();
}

class _SigninButtonState extends State<SigninButton> {
  bool isLoading = false;
  FirebaseService service = new FirebaseService();

  void showMessage(FirebaseAuthException e) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(e.message!),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                  print(e.code);
                  if (e.code == 'account-exists-with-different-credential') {
                    List<String> emailList = await FirebaseAuth.instance
                        .fetchSignInMethodsForEmail(e.email!);
                    if (emailList.first == "google.com") {
                      await this.service.signInwithGoogle();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                          (route) => false);
                      ;
                    }
                  }
                },
              )
            ],
          );
        });
  }

  Future<void> loginWithProviders() async {
    String? displayName;
    Resource? result;
    try {
      switch (this.widget.loginType) {
        case LoginType.Google:
          displayName = await service.signInwithGoogle();
          break;
        case LoginType.Facebook:
          result = await service.signInWithFacebook();
          break;
      }
      if (result!.status == Status.Success || displayName != null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        showMessage(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !isLoading
        ? SizedBox(
            width: size.width * 0.8,
            child: OutlinedButton.icon(
              icon: this.widget.faIcon,
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await this.loginWithProviders();
                setState(() {
                  isLoading = false;
                });
              },
              label: Text(
                this.widget.loginType == LoginType.Google
                    ? 'Google'
                    : 'Facebook',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                  side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
            ),
          )
        : CircularProgressIndicator();
  }
}

enum LoginType {
  Google,
  Facebook,
}

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }
