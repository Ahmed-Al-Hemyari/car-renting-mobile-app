import 'package:http/http.dart' as http;
import 'dart:convert';

class Booking {
  final num id;
  final String carImage;
  final String carName;
  final String carCategory;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final bool rated;

  Booking({
    required this.id,
    required this.carImage,
    required this.carName,
    required this.carCategory,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.rated,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? 0,
      carImage: json['car']['image'] ?? '',
      carName: json['car']['brand']['name'] + json['car']['name'] ?? '',
      carCategory: json['car']['category']['name'] ?? '',
      startDate: json['start_date'] ?? DateTime(0000, 00, 00),
      endDate: json['end_date'] ?? DateTime(0000, 00, 00),
      status: json['status'],
      rated: json['rated'],
    );
  }

  static Future<List<Booking>> bookingIndex(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> bookingsList = body['data'];

      return bookingsList.map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }
}
