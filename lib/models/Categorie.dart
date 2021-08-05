class Categorie {
  final String? id;
  final String? name;
  final String? dep_name;

  Categorie({this.id, this.name, this.dep_name});

  factory Categorie.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    return Categorie(
      id: json['_id'],
      name: json['name'],
      dep_name: json['dep_name'],
    );
  }
}
