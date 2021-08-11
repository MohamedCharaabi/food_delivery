import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/models/User.dart';
import 'package:food_delivery_flutter/pages/auth/login1.dart';
import 'package:food_delivery_flutter/pages/profile/widgets/AppTheme.dart';
import 'package:food_delivery_flutter/providers/user_provider.dart';
import 'package:food_delivery_flutter/services/firebase_crud.dart';
import 'package:food_delivery_flutter/services/firebase_services.dart';
import 'package:food_delivery_flutter/utils/SizeConfig.dart';
import 'package:food_delivery_flutter/utils/values/values.dart';
import 'package:provider/provider.dart';

import 'widgets/add_Adress.dart';
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
        body: FutureBuilder<UserModel>(
      future: FirebaseCrud().getUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        UserModel user = snapshot.data!;
        context.read<UserProvider>().addUser(user);
        return Column(
          children: <Widget>[
            Container(
              height: height * 0.4,
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
                        '${user.username}',
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
        );
      },
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
      child: Consumer<UserProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return Column(
            children: <Widget>[
              SizedBox(height: 20),
              profileRow('Profile', Icons.person, () {}),
              SizedBox(height: 14),
              profileRow('Adresses', Icons.location_city, () {
                showAdressBottomSheet(context);
              }),
              SizedBox(height: 14),
              profileRow('Coupon', Icons.filter, () {}),
              SizedBox(height: 14),
              profileRow('Logout', Icons.logout, () async {
                await FirebaseService().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              })
            ],
          );
        },
      ),
    );
  }
}

Widget profileRow(String title, IconData icon, Function tap) {
  return InkWell(
    onTap: () {
      tap();
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
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
      ),
    ),
  );
}

void showAdressBottomSheet(BuildContext context) {
  showBottomSheet(
      context: context,
      builder: (context) =>
          Consumer<UserProvider>(builder: (context, user, child) {
            if (user.user.adresses?.length == 0 || user.user.adresses == null) {
              return Container(
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAdress()));
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber,
                            ),
                            child: Center(child: Icon(Icons.add)),
                          ),
                        ),
                      ),
                      Center(
                        child: Text('No adress'),
                      ),
                    ],
                  ));
            }

            return ListView.builder(
                itemCount: user.user.adresses!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  String address = user.user.adresses![index];

                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$index',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '$address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                });
          }));
}
