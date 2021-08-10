import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery_flutter/pages/Cart/cart_page.dart';
import 'package:food_delivery_flutter/pages/favorite/favorite_page.dart';
import 'package:food_delivery_flutter/pages/home/home_page.dart';
import 'package:food_delivery_flutter/pages/order/order_page.dart';
// import 'package:food_delivery_flutter/pages/home/widgets/categories_view.dart';
// import 'package:food_delivery_flutter/pages/home/widgets/menu_view.dart';
// import 'package:food_delivery_flutter/pages/order/order_page.dart';
import 'package:food_delivery_flutter/pages/profile/profile_page.dart';
// import 'package:food_delivery_flutter/utils/responsive_helper.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:http/http.dart' as http;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
// import 'package:flutter_restaurant/helper/responsive_helper.dart';
// import 'package:flutter_restaurant/view/screens/menu/widget/options_view.dart';

class HomeTemplate extends StatefulWidget {
  const HomeTemplate({Key? key, this.indexPage}) : super(key: key);
  final int? indexPage;
  @override
  _HomeTemplateState createState() => _HomeTemplateState();
}

class _HomeTemplateState extends State<HomeTemplate> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CartPage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: Color(0xFFF4F7FC),
      drawer:
          //  ResponsiveHelper.isTab(context) ? Drawer(child: OptionsView(onTap: null)) :
          SizedBox(),
      appBar: null,
      body: _widgetOptions[widget.indexPage ?? _selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100]!,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: SalomonBottomBar(
          // unselectedItemColor: Color(0xFFFf0000),
          // selectedColorOpacity: 0.5,
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.shoppingBag),
              title: Text("Cart"),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite),
              title: Text("Favorites"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),

      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 20,
      //         color: Colors.black.withOpacity(.1),
      //       )
      //     ],
      //   ),
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      //       child: GNav(
      //         rippleColor: Colors.grey[300]!,
      //         hoverColor: Colors.grey[100]!,
      //         gap: 0,
      //         activeColor: Colors.black,
      //         iconSize: 24,
      //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //         duration: Duration(milliseconds: 400),
      //         tabBackgroundColor: Colors.grey[100]!,
      //         color: Colors.black,
      //         tabs: [
      //           GButton(
      //             icon: Icons.home,
      //             text: 'Home',
      //           ),
      //           GButton(
      //             icon: Icons.shopping_basket,
      //             text: 'Cart',
      //           ),
      //           GButton(
      //             icon: Icons.online_prediction_rounded,
      //             text: 'Orders',
      //           ),
      //           GButton(
      //             icon: Icons.favorite,
      //             text: 'Favorite',
      //           ),
      //           GButton(
      //             icon: Icons.person,
      //             text: 'Profile',
      //           ),
      //         ],
      //         selectedIndex: _selectedIndex,
      //         onTabChange: (index) {
      //           setState(() {
      //             _selectedIndex = index;
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
