class AddOn {
  final String? id;
  final String? name;
  final String? image;

  final String? status;
  final String? price;

  AddOn({
    this.id,
    this.name,
    this.image,
    this.status,
    this.price,
  });

  factory AddOn.fromMap(Map<String, dynamic> json, String id) {
    print(json.toString());
    return AddOn(
      id: id,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      price: json['price'] ?? '0.0',
    );
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'status': status,
      'price': price,
    };
  }
}
