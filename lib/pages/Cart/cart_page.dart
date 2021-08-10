import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_delivery_flutter/models/AddOn.dart';
import 'package:food_delivery_flutter/models/Menu.dart';
import 'package:food_delivery_flutter/pages/Cart/widgets/delivery_option_button.dart';
import 'package:food_delivery_flutter/pages/Cart/widgets/food_cart.dart';
import 'package:food_delivery_flutter/pages/Cart/widgets/no_data_screen.dart';
import 'package:food_delivery_flutter/providers/cart_provider.dart';
import 'package:food_delivery_flutter/services/firebase_crud.dart';
import 'package:food_delivery_flutter/utils/style.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int counter = 3;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('My Order'),
          centerTitle: true,
        ),
        body: Consumer<CartProvider>(builder: (context, cart, chid) {
          //
          if (cart.cartItems.isEmpty) {
            return NoDataScreen(isCart: true);
          }
          return Column(children: [
            Expanded(
                child: Scrollbar(
                    child: SingleChildScrollView(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        physics: BouncingScrollPhysics(),
                        child: Center(
                            child: SizedBox(
                          width: 1170,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cart.cartItems.length,
                                itemBuilder: (context, index) {
                                  return CartFood(menu: cart.cartItems[index]);
                                },
                              ),

                              SizedBox(height: 15),
                              FutureBuilder<List<AddOn>>(
                                  builder: (context, snapshot) {
                                return SizedBox();
                              }),
                              Text(
                                'Add On',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),

                              AddOnsItems(height: height),
                              SizedBox(height: 15),

                              Text(
                                'Bill Details',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              BillDetails(billItems: cart.cartItems),
                              SizedBox(height: 15),
                              SizedBox(
                                height: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Deliver to work',
                                            style: TextStyle(fontSize: 18)),
                                        Text(
                                          'CHANGE',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                        width: 200,
                                        child: Text(
                                          '201, Dev mall, near iskon cross roads',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff8d8d8d)),
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color(0xffea4212),
                                      borderRadius: BorderRadius.circular(11)),
                                  child: Center(
                                    child: Text(
                                      'MAKE ORDER',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  )),
                            ],
                          ),
                        )))))
          ]);
        }));
  }
}

class AddOnsItems extends StatefulWidget {
  const AddOnsItems({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  _AddOnsItemsState createState() => _AddOnsItemsState();
}

class _AddOnsItemsState extends State<AddOnsItems> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, child) {
      return Container(
          height: widget.height * 0.2,
          margin: EdgeInsets.only(right: 5),
          // color: Colors.amber,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: cart.addOnsItems.length,
                  itemBuilder: (context, index) {
                    AddOn _addOn = cart.addOnsItems[index];
                    return InkWell(
                      onLongPress: () {
                        showBottomSheet(
                            elevation: 2.5,
                            backgroundColor: Colors.red,
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 70,
                                child: Center(
                                  child: MaterialButton(
                                    // height: ,
                                    color: Colors.amber,
                                    child: Text('Remove'),
                                    onPressed: () {
                                      context
                                          .read<CartProvider>()
                                          .deleteAddOnItem(_addOn);
                                    },
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: '${_addOn.image}',
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
                            width: 5,
                          ),
                          Text('${_addOn.name}'),
                          SizedBox(
                            width: 5,
                          ),
                          Text('\$${_addOn.price}')
                        ],
                      )),
                    );
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      showSheet();
                    },
                    child: DottedBorder(
                      color: Colors.green,
                      strokeWidth: 1,
                      child: Container(
                        width: widget.height * 0.13,
                        height: widget.height * 0.13,
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }

  Future showSheet() => showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.4, 0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (BuildContext context, SheetState state) =>
              buildSheet(context, state),
        );
      });

  Widget buildSheet(context, state) => Material(
      child: FutureBuilder<List<AddOn>>(
          future: FirebaseCrud().fetchAddOns(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.all(15),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  AddOn addOn = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      context.read<CartProvider>().addAddOnItem(addOn);
                    },
                    child: Container(
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
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
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
                                        imageUrl: '${addOn.image}',
                                        placeholder: (context, url) =>
                                            Image.asset(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          addOn.name!.length > 15
                                              ? addOn.name!.substring(0, 15) +
                                                  '...'
                                              : '${addOn.name}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '\$ ${addOn.price}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }));
}

class BillDetails extends StatelessWidget {
  const BillDetails({Key? key, required this.billItems}) : super(key: key);
  final List<Menu> billItems;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Container(
            height: 280,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Item Total',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff8d8d8d)),
                      ),
                      Text('${cart.itemTotal.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Restaurant Charges',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xff8d8d8d))),
                      Text('\$${cart.restaurantCharges.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Delivery Fee',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xff8d8d8d))),
                      Text('\$${cart.delivery_fee.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Copon',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xff8d8d8d))),
                      Text('-\$${cart.couponsRemize().toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
                  Center(
                    child: Container(
                      // width: 90,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey,
                      height: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('To Pay',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff000000),
                          )),
                      Text('\$${cart.toPay.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff000000),
                          ))
                    ],
                  ),
                ]));
      },
    );
  }
}
