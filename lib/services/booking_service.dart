import 'package:car_renting/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:car_renting/classes/booking_class.dart';

class BookingService {
  final authService = AuthService();

  // Index all bookings

  Future<List<Booking>> BookingIndex(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await authService.getToken()}',
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> bookingsList = body['data'];

      return bookingsList.map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  // Cancel Booking

  Future<void> CancelBooking(int id, String url) async {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await authService.getToken()}',
      },
      body: jsonEncode({'status': 'cancelled', 'booking_id': id}),
    );

    print('Token: ${await authService.getToken()}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Booking cancelled successfully');
    } else {
      print('Failed to cancel booking: ${response.body}');
    }
  }
}
