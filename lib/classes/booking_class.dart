import 'package:http/http.dart' as http;
import 'dart:convert';

class Booking {
  final int id;
  final int carId;
  final String carImage;
  final String carName;
  final String carCategory;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final bool rated;

  Booking({
    required this.id,
    required this.carId,
    required this.carImage,
    required this.carName,
    required this.carCategory,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.rated,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    final car = json['car'] ?? {};
    final brand = car['brand'] ?? {};
    final category = car['category'] ?? {};

    final brandName = (brand['name'] ?? '').trim();
    final modelName = (car['name'] ?? '').trim();

    String displayName;
    if (brandName.isEmpty && modelName.isEmpty) {
      displayName = 'Unknown Car';
    } else if (brandName.isEmpty) {
      displayName = modelName;
    } else if (modelName.isEmpty) {
      displayName = brandName;
    } else {
      displayName = '$brandName $modelName';
    }

    DateTime parseDate(dynamic value) {
      if (value is String && value.isNotEmpty) return DateTime.parse(value);
      return DateTime(1970, 1, 1);
    }

    return Booking(
      id: json['id'] ?? 0,
      carId: car['id'] ?? int,
      carImage: car['image'] ?? '',
      carName: displayName,
      carCategory: category['name'] ?? '',
      startDate: parseDate(json['start_date']),
      endDate: parseDate(json['end_date']),
      status: json['status'] ?? '',
      rated: json['rated'] == 1 || json['rated'] == true,
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

  static Future<void> cancelBooking(int id, String url) async {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer your_token', // if you use auth
      },
      body: jsonEncode({'status': 'cancelled', 'booking_id': id}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Booking cancelled successfully');
    } else {
      print('Failed to cancel booking: ${response.body}');
    }
  }
}
