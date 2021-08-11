import 'package:flutter/widgets.dart';
import 'package:food_delivery_flutter/models/User.dart';

class UserProvider extends ChangeNotifier {
  UserModel user = new UserModel();

  void addUser(UserModel newuser) {
    user = newuser;
    notifyListeners();
  }
}

enum OrderType { delivery, take_away }
