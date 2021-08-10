import 'package:flutter/widgets.dart';
import 'package:food_delivery_flutter/models/Menu.dart';

class OrderProvider extends ChangeNotifier {
  List<Menu> ordersItems = [];

  OrderType orderType = OrderType.delivery;
  void addItem(Menu item) {
    if (!ordersItems.contains(item)) {
      ordersItems.add(item);
      notifyListeners();
    }
  }
}

enum OrderType { delivery, take_away }
