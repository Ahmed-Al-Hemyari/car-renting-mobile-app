import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:car_renting/classes/user_class.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String url,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];
        final userData = data['user'];

        if (token != null) {
          await _storage.write(key: 'token', value: token);
        }

        if (userData != null) {
          // Store as JSON string
          await _storage.write(key: 'user', value: jsonEncode(userData));
        }

        // Return parsed user
        return {'success': true, 'user': User.fromJson(userData)};
      } else {
        print('Registration failed: ${response.body}');
        return {
          'success': false,
          'message': 'Failed with status ${response.statusCode}',
        };
      }
    } catch (e) {
      print('Error registering: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String url,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];
        final userData = data['user'];

        if (token != null) {
          await _storage.write(key: 'token', value: token);
        }

        if (userData != null) {
          // Store as JSON string
          await _storage.write(key: 'user', value: jsonEncode(userData));
        }

        // Return parsed user
        return {'success': true, 'user': User.fromJson(userData)};
      } else {
        print('Login failed: ${response.body}');
        return {
          'success': false,
          'message': 'Failed with status ${response.statusCode}',
        };
      }
    } catch (e) {
      print('Error login: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Get token
  Future<String?> getToken() async => await _storage.read(key: 'token');

  // Get User Info
  Future<User?> getUser() async {
    String? userJson = await _storage.read(key: 'user');
    if (userJson == null) return null;
    return User.fromJson(jsonDecode(userJson));
  }

  // Logout
  Future<void> logout() async {
    await _storage.deleteAll();
  }

  // Check authenicated
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
