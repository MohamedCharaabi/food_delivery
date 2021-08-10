import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery_flutter/models/Menu.dart';
import 'package:food_delivery_flutter/pages/home/home_template.dart';
import 'package:food_delivery_flutter/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({Key? key, required this.selectedFood}) : super(key: key);

  final Menu selectedFood;

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  int _selectedTab = 0;
  List<Widget> tabs = [Text('hahhhhhhhhhhh'), Text('RRRRRRR')];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            SizedBox(),
            Container(
              height: height * 0.4,
              width: width,
              child: CachedNetworkImage(
                imageUrl: '${widget.selectedFood.image}',
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              top: height * 0.35,
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 200,
                              child: Text(
                                '${widget.selectedFood.name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Text(
                                '\$${widget.selectedFood.price}',
                                style: TextStyle(
                                    color: Color(0xffbc2c3d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              foodStatItem(
                                  widget.selectedFood,
                                  Icons.star,
                                  Colors.white,
                                  Color(0xffffb135),
                                  '${widget.selectedFood.rating}',
                                  'Rating'),
                              foodStatItem(
                                  widget.selectedFood,
                                  Icons.favorite,
                                  Colors.white,
                                  Color(0xffbc2c3d),
                                  '${widget.selectedFood.favs}',
                                  'favorites'),
                              foodStatItem(
                                  widget.selectedFood,
                                  Icons.watch,
                                  Colors.white,
                                  Color(0xff2c2627),
                                  '${widget.selectedFood.time}',
                                  'time'),
                            ]),
                        SizedBox(height: 15),
                        Text(
                          'Details',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('${widget.selectedFood.desc}'),

                        // Expanded(child: tabs[_selectedTab])
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //Add to cart
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: InkWell(
                onTap: () {
                  context.read<CartProvider>().addItem(widget.selectedFood);
                },
                child: Container(
                  // alignment: Alignment.center,
                  height: 50,
                  // width: width * 0.9,
                  decoration: BoxDecoration(
                    color: Color(0xffbc2c3d),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Add to Cart',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 15),
                        Icon(
                          Icons.shopping_basket,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //top cart and arrow_back
            Positioned(
                top: 15,
                right: 15,
                left: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Consumer<CartProvider>(builder: (context, cart, child) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeTemplate(
                                        indexPage: 1,
                                      )));
                        },
                        child: Badge(
                            badgeContent: Text(cart.cartItems.length > 0
                                ? '${cart.cartItems.length}'
                                : ''),
                            child: Icon(
                              FontAwesomeIcons.cartPlus,
                              color: Colors.white,
                            )),
                      );
                    })
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

Widget foodStatItem(Menu food, IconData icon, Color iconColor, Color mainColor,
    String stat, String text) {
  return Row(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(5.0),
        margin: EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          color: mainColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$stat',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('$text'),
        ],
      )
    ],
  );
}
