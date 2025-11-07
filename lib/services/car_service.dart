import 'package:car_renting/classes/car_class.dart';
import 'package:car_renting/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarService {
  final authService = AuthService();

  /// Fetch cars with optional filters
  Future<List<Car>> CarIndex(
    String url, {
    String? search,
    String? brand,
    String? category,
    double? maxPrice,
    double? minRate,
    int page = 1, // 👈 new page argument
  }) async {
    final token = await authService.getToken();
    if (token == null) {
      throw Exception('User not logged in');
    }

    final queryParameters = <String, String>{};

    if (search != null && search.isNotEmpty) queryParameters['search'] = search;
    if (brand != null && brand.isNotEmpty) queryParameters['brand'] = brand;
    if (category != null && category.isNotEmpty)
      queryParameters['category'] = category;
    if (maxPrice != null) queryParameters['price'] = '0-${maxPrice.toInt()}';
    if (minRate != null) queryParameters['rate'] = '${minRate.toString()}+';

    queryParameters['page'] = page.toString(); // 👈 add page number

    final uri = Uri.parse(url).replace(queryParameters: queryParameters);

    final res = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Fetching: $uri');
    print('Response: ${res.statusCode} ${res.body}');

    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body);

      final carsList = decoded['data'] ?? [];
      final meta = decoded['meta'];

      // optional: print pagination info
      print('Page ${meta['current_page']} of ${meta['last_page']}');

      return (carsList as List).map((json) => Car.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cars: ${res.body}');
    }
  }
}
