import 'package:food_delivery_flutter/models/Menu.dart';

class MenuFavs {
  final List<Menu>? menu;
  final List<String>? favs;

  MenuFavs({this.menu, this.favs});

  factory MenuFavs.fromMap(Map<String, dynamic> json, String id) {
    print(json.toString());
    return MenuFavs(
      menu: json['menus'] ?? [],
      favs: json['favs'] ?? [],
    );
  }

  //  Menu.fromSnapshot(DocumentSnapshot snapshot)
  //     : this.fromMap(snapshot.data, snapshot.id);

}
