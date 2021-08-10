import 'package:cloud_firestore/cloud_firestore.dart';

class Categorie {
  final String? id;
  final String? name;
  final String? image;

  final String? status;

  Categorie({
    this.id,
    this.name,
    this.image,
    this.status,
  });

  factory Categorie.fromMap(Map<String, dynamic> json, String id) {
    print(json.toString());
    return Categorie(
      id: id,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
    );
  }

  //  Categorie.fromSnapshot(DocumentSnapshot snapshot)
  //     : this.fromMap(snapshot.data, snapshot.id);

  toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'status': status,
    };
  }
}
