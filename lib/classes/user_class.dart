class User {
  final int id;
  final String name;
  final String? image;
  final String email;

  User({required this.id, required this.name, this.image, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'],
      image: json['image'] ?? '',
      email: json['email'],
    );
  }
}
