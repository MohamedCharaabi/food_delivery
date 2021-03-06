class UserModel {
  final String? id;
  final String? username;
  final String? image;
  final String? phone;
  final String? status;
  List<String>? favorites;
  List<String>? adresses;

  UserModel(
      {this.id,
      this.username,
      this.image,
      this.phone,
      this.status,
      this.favorites,
      this.adresses});

  factory UserModel.fromMap(Map<String, dynamic> json, String id) {
    print(json.toString());
    return UserModel(
      id: id,
      username: json['username'] ?? '',
      image: json['image'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? '',
      favorites: json['favorites'].cast<String>() ?? [],
      adresses: json['adresses'] != null ? json['adresses'].cast<String>() : [],
    );
  }

  //  UserModel.fromSnapshot(DocumentSnapshot snapshot)
  //     : this.fromMap(snapshot.data, snapshot.id);

  toJson() {
    return {
      'id': id,
      'username': username,
      'image': image,
      'phone': phone,
      'status': status,
      'favorites': favorites
    };
  }
}
