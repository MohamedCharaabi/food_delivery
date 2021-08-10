import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:food_delivery_flutter/models/AddOn.dart';
import 'package:food_delivery_flutter/models/Menu.dart';

class CartProvider extends ChangeNotifier {
  List<Menu> cartItems = [];
  List<AddOn> addOnsItems = [];
  List<AddOnItem> addOnsQuantity = [];
  List<CartItem> quantity = [];
  double restaurantCharges = 0;
  double delivery_fee = 0;
  List<Coupon> coupons = [];
  double itemTotal = 0;
  double toPay = 0;

  void countToPay() {
    double couoponsRemise = 0;
    coupons.forEach((element) {
      couoponsRemise += element.remise;
    });
    toPay = this.itemTotal +
        this.restaurantCharges +
        this.delivery_fee -
        couoponsRemise;
  }

  void addItem(Menu item) {
    if (!cartItems.contains(item)) {
      cartItems.add(item);
      CartItem itemQuantity =
          new CartItem(item, 1, double.parse('${item.price}'));
      quantity.add(itemQuantity);
      itemTotal += double.parse('${item.price}');
      countToPay();
      notifyListeners();
    }
  }

  void addAddOnItem(AddOn item) {
    // if (!addOnsItems.contains(item)) {
    addOnsItems.add(item);
    AddOnItem addOn = new AddOnItem(item, 1, double.parse('${item.price}'));
    addOnsQuantity.add(addOn);
    itemTotal += double.parse('${item.price}');
    countToPay();
    notifyListeners();
    // }
  }

  void deleteItem(Menu item) {
    if (cartItems.contains(item)) {
      cartItems.remove(item);
      CartItem itemQuantity =
          new CartItem(item, 1, double.parse('${item.price}'));
      CartItem selectedItem =
          quantity.where((element) => element.menu == item).first;
      quantity.remove(selectedItem);
      itemTotal -= double.parse('${item.price}');
      countToPay();
      notifyListeners();
    }
  }

  void deleteAddOnItem(AddOn item) {
    if (addOnsItems.contains(item)) {
      addOnsItems.remove(item);
      AddOnItem itemQuantity =
          new AddOnItem(item, 1, double.parse('${item.price}'));
      AddOnItem selectedItem =
          addOnsQuantity.where((element) => element._addOn == item).first;
      addOnsQuantity.remove(selectedItem);
      itemTotal -= double.parse('${item.price}');
      countToPay();
      notifyListeners();
    }
  }

  void addQuantiy(Menu item) {
    quantity.where((element) => element.menu == item).first.incrementQuantity();
    quantity.map((e) => log('e.quantity'));
    itemTotal += double.parse('${item.price}');
    countToPay();
    notifyListeners();
  }

  void mineQuantiy(Menu item) {
    quantity.where((element) => element.menu == item).first.decrimentQuantity();
    // quantity.map((e) => log('e.quantity'));
    itemTotal -= double.parse('${item.price}');
    countToPay();
    notifyListeners();
  }

  int getQuantity(Menu item) {
    CartItem selectedItem =
        quantity.where((element) => element.menu == item).first;
    return selectedItem.quantity;
  }

  double couponsRemize() {
    double couoponsRemise = 0;
    coupons.forEach((element) {
      couoponsRemise += element.remise;
    });
    return couoponsRemise;
  }
}

class CartItem {
  Menu menu;
  int quantity;
  double price;

  CartItem(this.menu, this.quantity, this.price);

  void incrementQuantity() {
    this.quantity++;
    this.price = double.parse('${menu.price}') * this.quantity;
  }

  decrimentQuantity() {
    this.quantity--;
    this.price = double.parse('${menu.price}') * this.quantity;
  }

  // get f => this.quantity;
}

class Coupon {
  Menu menu;
  int quantity;
  double price;
  String id;
  double remise;

  Coupon(this.menu, this.quantity, this.price, this.id, this.remise);

  void incrementQuantity() {
    this.quantity++;
    this.price = double.parse('${menu.price}') * this.quantity;
  }

  decrimentQuantity() {
    this.quantity--;
    this.price = double.parse('${menu.price}') * this.quantity;
  }

  // get f => this.quantity;
}

class AddOnItem {
  AddOn _addOn;
  int quantity;
  double price;

  AddOnItem(this._addOn, this.quantity, this.price);

  void incrementQuantity() {
    this.quantity++;
    this.price = double.parse('${_addOn.price}') * this.quantity;
  }

  decrimentQuantity() {
    this.quantity--;
    this.price = double.parse('${_addOn.price}') * this.quantity;
  }
}
