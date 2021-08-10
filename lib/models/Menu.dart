class Menu {
  final String? id;
  final String? name;
  final String? image;
  final String? desc;
  final String? status;
  final String? price;
  final String? rating;
  final List? categorie;
  final String? orderNumber;
  final String? time;
  final String? favs;

  Menu(
      {this.id,
      this.name,
      this.image,
      this.desc,
      this.status,
      this.price,
      this.rating,
      this.categorie,
      this.orderNumber,
      this.time,
      this.favs});

  factory Menu.fromMap(Map<String, dynamic> json, String id) {
    print(json.toString());
    return Menu(
        id: id,
        name: json['name'] ?? '',
        image: json['image'] ?? '',
        desc: json['description'] ?? '',
        status: json['status'] ?? '',
        price: json['price'] ?? '0.0',
        rating: json['rating'] ?? '0.0',
        categorie: json['categorie'] ?? [],
        orderNumber: json['orders'] ?? '',
        time: json['time'] ?? '',
        favs: json['favs'] ?? '0');
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': desc,
      'status': status,
      'price': price,
      'rating': rating,
    };
  }
}
