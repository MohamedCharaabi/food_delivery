import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/utils/images.dart';
import 'package:food_delivery_flutter/utils/style.dart';
// import 'package:flutter_restaurant/localization/language_constrants.dart';
// import 'package:flutter_restaurant/utill/dimensions.dart';
// import 'package:flutter_restaurant/utill/images.dart';
// import 'package:flutter_restaurant/utill/styles.dart';

class NoDataScreen extends StatelessWidget {
  final bool isOrder;
  final bool isCart;
  final bool isNothing;
  NoDataScreen(
      {this.isCart = false, this.isNothing = false, this.isOrder = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              isOrder
                  ? Images.clock
                  : isCart
                      ? Images.shopping_cart
                      : Images.binoculars,
              width: MediaQuery.of(context).size.height * 0.22,
              height: MediaQuery.of(context).size.height * 0.22,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              isOrder
                  ? 'no_order_history_available'
                  : isCart
                      ? 'empty_cart'
                      : 'nothing_found',
              style: rubikBold.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: MediaQuery.of(context).size.height * 0.023),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              isOrder
                  ? 'buy_something_to_see'
                  : isCart
                      ? 'look_like_have_not_added'
                      : '',
              style: rubikMedium.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.0175),
              textAlign: TextAlign.center,
            ),
          ]),
    );
  }
}
