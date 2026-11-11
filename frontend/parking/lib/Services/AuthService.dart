
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'ApiService.dart';

class AuthService {
  static const FlutterSecureStorage _storage =
      FlutterSecureStorage();

  static const String _tokenKey = 'park_it_token';

  // Login
  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    final response = await ApiService.post(
      '/auth/login',
      {
        'username': username.trim(),
        'password': password,
      },
    );

    final token = response['token'];

    if (token == null || token is! String) {
      throw Exception('Authentication token missing');
    }

    await _storage.write(
      key: _tokenKey,
      value: token,
    );

    return response;
  }
  // Signup
static Future<Map<String, dynamic>> signup(
  String username,
  String email,
  String password,
) async {
  final response = await ApiService.post(
    '/auth/signup',
    {
      'username': username.trim(),
      'email': email.trim().toLowerCase(),
      'password': password,
    },
  );

  final token = response['token'];

  if (token == null || token is! String) {
    throw Exception('Authentication token missing');
  }

  await _storage.write(
    key: _tokenKey,
    value: token,
  );

  return response;
}
  // Retrieve stored token
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Logout
  static Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }

  // Current user
  static Future<Map<String, dynamic>> getMe() async {
    final token = await getToken();

    if (token == null) {
      throw Exception('Please login first');
    }

    return await ApiService.get(
      '/auth/me',
      token: token,
    );
  }
}
