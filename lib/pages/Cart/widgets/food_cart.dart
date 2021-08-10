import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/models/Menu.dart';
import 'package:food_delivery_flutter/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartFood extends StatefulWidget {
  final Menu menu;
  const CartFood({Key? key, required this.menu}) : super(key: key);

  @override
  _CartFoodState createState() => _CartFoodState();
}

class _CartFoodState extends State<CartFood> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, child) {
      return Container(
        height: 90,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(right: 2),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: '${widget.menu.image}',
                          placeholder: (context, url) => Image.asset(
                            'assets/images/icon-food.jpg',
                            width: 70,
                            height: 70,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            widget.menu.name!.length > 15
                                ? widget.menu.name!.substring(0, 15) + '...'
                                : '${widget.menu.name}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '\$ ${widget.menu.price}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  )),
            ),
            Flexible(
              flex: 1,
              child: Center(
                child: Container(
                  width: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.green,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            if (quantity > 0) {
                              setState(() {
                                quantity -= 1;
                              });
                              context
                                  .read<CartProvider>()
                                  .mineQuantiy(widget.menu);
                            }
                          },
                          child: Icon(Icons.remove)),
                      Text('${cart.getQuantity(widget.menu)}'),
                      InkWell(
                          onTap: () {
                            setState(() {
                              quantity += 1;
                            });
                            context
                                .read<CartProvider>()
                                .addQuantiy(widget.menu);
                          },
                          child: Icon(Icons.add)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
