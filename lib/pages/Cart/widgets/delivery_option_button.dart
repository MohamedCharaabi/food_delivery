import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/utils/style.dart';
// import 'package:flutter_restaurant/helper/price_converter.dart';
// import 'package:flutter_restaurant/localization/language_constrants.dart';
// import 'package:flutter_restaurant/provider/order_provider.dart';
// import 'package:flutter_restaurant/provider/splash_provider.dart';
// import 'package:flutter_restaurant/utill/dimensions.dart';
// import 'package:flutter_restaurant/utill/styles.dart';
import 'package:provider/provider.dart';

class DeliveryOptionButton extends StatelessWidget {
  final String value;
  final String title;
  DeliveryOptionButton({required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => order.setOrderType(value),
      child: Row(
        children: [
          Radio(
            value: value,
            // groupValue: order.orderType,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (String? value) => print('$value'),
            groupValue: 'order',
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Text(title, style: rubikRegular),
          SizedBox(width: 5),
          Text('Delivery', style: rubikMedium),
        ],
      ),
    );
  }
}
