import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // For Flutter Web / Chrome:
  static const String baseUrl = 'http://localhost:5000/api';

  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> get(
    String endpoint, {
    String? token,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );

    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(
    http.Response response,
  ) {
    final decoded = response.body.isNotEmpty
        ? jsonDecode(response.body)
        : <String, dynamic>{};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return {'data': decoded};
    }

    final message = decoded is Map<String, dynamic>
        ? decoded['message'] ?? decoded['error']
        : null;

    throw Exception(
      message?.toString() ??
          'Request failed with status ${response.statusCode}',
    );
  }
}
