class SWEntity {
  final String id;
  final String name;
  final String description;
  final String image;
  final String category; // e.g., "character", "creature", "droid", etc.

  SWEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
  });

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
