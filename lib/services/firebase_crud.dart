import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_flutter/models/Menu.dart';

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

  Future<List<Menu>> fetchBanners() async {
    final Api _api = Api('banners');
    List<Menu> menus = [];
    var result = await _api.getDataCollection();
    menus = result.docs
        .map((doc) => Menu.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    return menus;
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
