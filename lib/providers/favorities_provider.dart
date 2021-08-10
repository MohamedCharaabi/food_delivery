import 'package:flutter/widgets.dart';
import 'package:food_delivery_flutter/models/Menu.dart';
import 'package:food_delivery_flutter/services/firebase_crud.dart';

class FavoritiesProvider extends ChangeNotifier {
  List<String> favsItems = [];

  OrderType orderType = OrderType.delivery;
  // void addItem(Menu item) {
  //   if (!ordersItems.contains(item)) {
  //     ordersItems.add(item);
  //     notifyListeners();
  //   }
  // }

  void setList(List<String> list) {
    favsItems = list;
    notifyListeners();
  }

  Future favClick(Menu menu) async {
    if (favsItems.contains(menu.id)) {
      favsItems.remove(menu.id);
    } else {
      favsItems.add(menu.id!);
    }
    bool? result = await FirebaseCrud().UpadateFavorites(favsItems);
    notifyListeners();

    return result;
  }
}

enum OrderType { delivery, take_away }
