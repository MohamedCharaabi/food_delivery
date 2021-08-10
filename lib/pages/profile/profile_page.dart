import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/pages/profile/widgets/AppTheme.dart';
import 'package:food_delivery_flutter/utils/SizeConfig.dart';
import 'package:food_delivery_flutter/utils/values/values.dart';
// import 'package:food_delivery_flutter/utils/colors2.dart';
// import 'package:food_delivery_flutter/utils/sizes.dart';
// import 'package:food_delivery_flutter/utils/values/sizes.dart';
// import 'package:food_delivery_flutter/utils/values/values.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ThemeData themeData = ThemeData();

  int selectedTab = 0;
  List<Widget> tabs = <Widget>[
    ProfileTab(),
    Text('Orders'),
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: height * 0.4,
          // color: Colors.amber,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background-profile.jpg'),
                  fit: BoxFit.cover)),
          child: Stack(children: <Widget>[
            Positioned(
              top: height * 0.1,
              left: width * 0.1,
              right: width * 0.1,
              child: Column(
                children: <Widget>[
                  Container(
                    height: height * 0.15,
                    width: height * 0.15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amber),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Name LastName ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 15,
              right: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  tabProfile(() {
                    setState(() {
                      selectedTab = 0;
                    });
                  }, 'Profile', selectedTab == 0 ? true : false),
                  tabProfile(() {
                    setState(() {
                      selectedTab = 1;
                    });
                  }, 'Orders', selectedTab == 1 ? true : false),
                ],
              ),
            ),
          ]),
        ),
        Expanded(child: tabs[selectedTab])
      ],
    ));
  }

  InkWell tabProfile(Function tap, String text, bool selected) {
    return InkWell(
      onTap: () {
        tap();
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            Text(
              '$text',
              style: tabTxtStyle,
            ),
            SizedBox(height: 8),
            Container(
              height: selected ? 3 : 0,
              width: 60,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

TextStyle tabTxtStyle = new TextStyle(fontSize: 18, color: Colors.white);

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          profileRow('Profile', Icons.person),
          SizedBox(height: 14),
          profileRow('Adresses', Icons.location_city),
          SizedBox(height: 14),
          profileRow('Coupon', Icons.filter),
          SizedBox(height: 14),
          profileRow('Logout', Icons.logout)
        ],
      ),
    );
  }
}

Widget profileRow(String title, IconData icon) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      SizedBox(
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              '$title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      Icon(Icons.arrow_forward_ios, size: 20),
    ],
  );
}
