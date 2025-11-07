class Rate {
  final int id;
  final double rate;
  final String comment;
  final String userName;
  final String? userImage;
  final int userId;

  Rate({
    required this.id,
    required this.rate,
    required this.comment,
    required this.userName,
    required this.userId,
    this.userImage,
  });

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      id: json['id'] ?? 0,
      rate: (json['rate'] is String)
          ? double.tryParse(json['rate']) ?? 0.0
          : (json['rate']?.toDouble() ?? 0.0),
      comment: json['comment'] ?? '',
      userName: json['user']?['name'] ?? '',
      userImage: json['user']?['image'],
      userId: json['user']?['id'] ?? 0,
    );
  }
}
