import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  static Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.post(
      Uri.parse(url),
      headers: headers ??
          {
            "Content-Type": "application/json",
          },
      body: body != null ? jsonEncode(body) : null, //
    );
  }


  // ✅ GET METHOD
  static Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    return await http.get(
      Uri.parse(url),
      headers: headers ?? {
        "Content-Type": "application/json",
      },
    );
  }
}
