import 'dart:convert';
import 'package:http/http.dart' as http;

class Car {
  final String? image;
  final String brand;
  final String name;
  final String category;
  // final bool availability;
  final double price;
  final double rate;
  final List<String> unavailableDates;

  Car({
    required this.image,
    required this.brand,
    required this.name,
    required this.category,
    required this.price,
    required this.rate,
    required this.unavailableDates,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      image: json['image'] ?? '',
      brand: json['brand'] != null ? json['brand']['name'] ?? '' : '',
      name: json['name'] ?? '',
      category: json['category'] != null ? json['category']['name'] ?? '' : '',
      unavailableDates: List<String>.from(json['unavailableDates'] ?? []),
      price: (json['price'] is String)
          ? double.tryParse(json['price']) ?? 0.0
          : (json['price']?.toDouble() ?? 0.0),
      rate: (json['rate'] is String)
          ? double.tryParse(json['rate']) ?? 0.0
          : (json['rate']?.toDouble() ?? 0.0),
    );
  }
}
