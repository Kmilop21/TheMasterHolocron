class Character {
  final String id;
  final String name;
  final String description;
  final String image;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  // To convert a Character to/from JSON
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }
}
