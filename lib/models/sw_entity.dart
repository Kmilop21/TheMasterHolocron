class SWEntity {
  final String id;
  final String name;
  final String description;
  final String image;
  final String category;

  SWEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'category': category,
    };
  }

  factory SWEntity.fromMap(Map<String, dynamic> map) {
    return SWEntity(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      category: map['category'],
    );
  }

  factory SWEntity.fromJson(Map<String, dynamic> json, String category) {
    return SWEntity(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      category: category,
    );
  }
}
