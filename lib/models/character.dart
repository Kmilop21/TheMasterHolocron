class Character {
  final String name;
  final String description;
  final String image;

  Character(
      {required this.name, required this.description, required this.image});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
