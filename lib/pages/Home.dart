import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/pages/auth/login1.dart';
import 'package:food_delivery_flutter/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: Center(
          child: MaterialButton(
            onPressed: () async {
              await FirebaseService().signOutFromGoogle();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            },
            child: Text('Logout'),
          ),
        ),
      ),
    );
    ;
  }
}
