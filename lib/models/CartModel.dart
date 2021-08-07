class CartModel {
  final String? id;
  final String? name;
  final String? dep_name;

  CartModel({this.id, this.name, this.dep_name});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    return CartModel(
      id: json['_id'],
      name: json['name'],
      dep_name: json['dep_name'],
    );
  }
}
