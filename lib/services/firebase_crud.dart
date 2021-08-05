import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCrud {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Categories
  Future<QuerySnapshot> readCategories() {
    CollectionReference categories = _firestore.collection('categories');

    return categories.get();
  }

//Products
  Future<QuerySnapshot> readProducts() {
    CollectionReference products = _firestore.collection('products');

    return products.get();
  }

  //Products
  Future<QuerySnapshot> readMenus() {
    CollectionReference menus = _firestore.collection('menus');

    return menus.get();
  }

  //Banners
  Future<QuerySnapshot> readBanners() {
    CollectionReference banners = _firestore.collection('banners');

    return banners.get();
  }
}
