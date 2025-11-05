import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:car_renting/classes/booking_class.dart';

// Index all bookings

Future<List<Booking>> bookingIndex(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final body = json.decode(response.body);
    final List<dynamic> bookingsList = body['data'];

    return bookingsList.map((json) => Booking.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load bookings');
  }
}

// Cancel Booking

Future<void> cancelBooking(int id, String url) async {
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
