import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_flutter/models/AddOn.dart';
import 'package:food_delivery_flutter/models/Categorie.dart';
import 'package:food_delivery_flutter/models/Menu.dart';
import 'package:food_delivery_flutter/models/User.dart';
// import 'package:food_delivery_flutter/providers/cart_provider.dart';
import 'package:food_delivery_flutter/providers/favorities_provider.dart';
import 'package:provider/provider.dart';

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

  Future<List<Menu>> fetchProducts() async {
    final Api _api = Api('menus');
    List<Menu> menus = [];
    var result = await _api.getDataCollection();
    menus = result.docs
        .map((doc) => Menu.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    return menus;
  }

  Future<List<Categorie>> fetchCategories() async {
    final Api _api = Api('categories');
    List<Categorie> cats = [];
    var result = await _api.getDataCollection();
    cats = result.docs
        .map((doc) =>
            Categorie.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    return cats;
  }

  Future<List<Menu>> fetchBanners() async {
    final Api _api = Api('banners');
    List<Menu> menus = [];
    var result = await _api.getDataCollection();
    menus = result.docs
        .map((doc) => Menu.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    return menus;
  }

  Future<List<AddOn>> fetchAddOns() async {
    final Api _api = Api('add-ons');
    List<AddOn> addOn = [];
    var result = await _api.getDataCollection();
    addOn = result.docs
        .map((doc) => AddOn.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    return addOn;
  }

  Future<List<Menu>> fetchMenuCat(
      String cat, BuildContext con, String id) async {
    final Api _api = Api('menus');
    List<Menu> menus = [];
    var result = await _api.getDocumentByCat(cat);
    log('result ==> $result');
    menus = result.docs
        .map((doc) => Menu.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    List<String>? favorities = await fetchUserFavorites(id);
    con.read<FavoritiesProvider>().setList(favorities ?? []);

    return menus;
  }

  Future<List<String>?> fetchUserFavorites(String id) async {
    final Api _api = Api('users');
    List<String>? fovorites = [];
    // log('uid ==> $id');
    var result = await _api.getDocumentByfavorites(id);
    // log('result ==> ${result.data()}');
    UserModel user =
        UserModel.fromMap(result.data() as Map<String, dynamic>, id);
    // log('user ==> $user');
    fovorites = user.favorites;
    // log('favories ==> ${user.favorites}');
    return fovorites;
  }

  Future<bool?> UpadateFavorites(List<String> newFavorities) async {
    final Api _api = Api('users');
    String user = FirebaseAuth.instance.currentUser!.uid;
    var userState = await _api.getDocumentById(user);
    UserModel userModel =
        UserModel.fromMap(userState.data() as Map<String, dynamic>, user);
    userModel.favorites = newFavorities;
    await _api
        .updateDocument(userModel.toJson(), user)
        .then((value) => true)
        .catchError((err) => false);
  }
}

class Api {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference? ref;

  Api(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref!.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref!.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref!.doc(id).get();
  }

  Future<QuerySnapshot> getDocumentByCat(String cat) {
    return ref!.where('categorie', arrayContains: cat).get();
  }

  Future<DocumentSnapshot> getDocumentByfavorites(String id) {
    return ref!.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref!.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref!.add(data);
  }

  Future<void> updateDocument(Map<String, dynamic> data, String id) {
    return ref!.doc(id).update(data);
  }
}
