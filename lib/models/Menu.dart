import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  final String? id;
  final String? name;
  final String? image;
  final String? desc;
  final String? status;
  final String? price;
  final String? rating;

  Menu(
      {this.id,
      this.name,
      this.image,
      this.desc,
      this.status,
      this.price,
      this.rating});

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
    );
  }

  //  Menu.fromSnapshot(DocumentSnapshot snapshot)
  //     : this.fromMap(snapshot.data, snapshot.id);

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
