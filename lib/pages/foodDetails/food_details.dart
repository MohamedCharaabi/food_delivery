import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/models/Menu.dart';

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Text('${widget.selectedFood.name}'),
                          ),
                          Text('${widget.selectedFood.price}')
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
                                '4.7',
                                'Rating'),
                            foodStatItem(
                                widget.selectedFood,
                                Icons.favorite,
                                Colors.white,
                                Color(0xffbc2c3d),
                                '4.7',
                                'Rating'),
                            foodStatItem(
                                widget.selectedFood,
                                Icons.picture_as_pdf,
                                Colors.white,
                                Color(0xff2c2627),
                                '4.7',
                                'Rating'),
                          ]),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedTab = 0;
                                      });
                                    },
                                    child: Text('Details',
                                        style: TextStyle(
                                          color: _selectedTab == 0
                                              ? Color(0xffbc2c3d)
                                              : Color(0xff2c2627),
                                        ))),
                              ),
                              Container(
                                  height: _selectedTab == 0 ? 2 : 0,
                                  width: 55,
                                  color: Color(0xffbc2c3d)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedTab = 1;
                                      });
                                    },
                                    child: Text('Reviews',
                                        style: TextStyle(
                                          color: _selectedTab == 1
                                              ? Color(0xffbc2c3d)
                                              : Color(0xff2c2627),
                                        ))),
                              ),
                              Container(
                                  height: _selectedTab == 1 ? 2 : 0,
                                  width: 55,
                                  color: Color(0xffbc2c3d)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Expanded(child: tabs[_selectedTab])
                    ],
                  ),
                ),
              ),
            ),
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
        children: <Widget>[
          Text('$stat'),
          Text('$text'),
        ],
      )
    ],
  );
}
