class Product {
  final String? id;
  final String? name;
  final String? dep_name;

  Product({this.id, this.name, this.dep_name});

  factory Product.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    return Product(
      id: json['_id'],
      name: json['name'],
      dep_name: json['dep_name'],
    );
  }
}
