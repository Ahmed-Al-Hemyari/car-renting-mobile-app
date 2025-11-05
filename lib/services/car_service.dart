import 'package:car_renting/classes/car_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Car>> CarIndex(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final body = json.decode(response.body);
    final List<dynamic> carList = body['data'];

    return carList.map((json) => Car.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load cars');
  }
}
