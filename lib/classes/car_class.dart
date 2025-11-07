import 'package:car_renting/classes/rate_class.dart';

class Car {
  final int id;
  final String image;
  final String brand;
  final String name;
  final String category;
  final double price;
  final double rate;
  final List<String> unavailableDates;
  final List<Rate> rates; // 👈 new field

  Car({
    required this.id,
    required this.image,
    required this.brand,
    required this.name,
    required this.category,
    required this.price,
    required this.rate,
    required this.unavailableDates,
    required this.rates,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      brand: json['brand']?['name'] ?? '',
      name: json['name'] ?? '',
      category: json['category']?['name'] ?? '',
      unavailableDates: List<String>.from(json['unavailable_dates'] ?? []),
      price: (json['price'] is String)
          ? double.tryParse(json['price']) ?? 0.0
          : (json['price']?.toDouble() ?? 0.0),
      rate: (json['rate'] is String)
          ? double.tryParse(json['rate']) ?? 0.0
          : (json['rate']?.toDouble() ?? 0.0),

      // ✅ Map rates safely
      rates: (json['rates'] != null)
          ? (json['rates'] as List).map((r) => Rate.fromJson(r)).toList()
          : [],
    );
  }
}
