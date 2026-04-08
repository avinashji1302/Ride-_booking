import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mime/mime.dart';

class HttpClient {
  //Post method
  static Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.post(
      Uri.parse(url),
      headers: headers ?? {"Content-Type": "application/json"},
      body: body != null ? jsonEncode(body) : null, //
    );
  }

  //  GET METHOD
  static Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    return await http.get(
      Uri.parse(url),
      headers: headers ?? {"Content-Type": "application/json"},
    );
  }

  //put method

  static Future<http.Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.put(
      Uri.parse(url),
      headers: headers ?? {"Content-Type": "application/json"},
      body: body != null ? jsonEncode(body) : null, 
    );
  }

  // DELETE METHOD
static Future<http.Response> delete(
  String url, {
  Map<String, String>? headers,
  Object? body,
}) async {
  return await http.delete(
    Uri.parse(url),
    headers: headers ?? {"Content-Type": "application/json"},
    body: body != null ? jsonEncode(body) : null,
  );
}


  // 🔥 MULTIPART (IMAGE UPLOAD)
// In your HttpClient.multipart method:


static Future<http.Response> multipart(
  String url, {
  required File file,
  required String fieldName,
  required Map<String, String> headers,
}) async {
  final request = http.MultipartRequest("POST", Uri.parse(url));
  request.headers.addAll(headers);

  // Auto-detect MIME type
  final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
  final mimeTypeParts = mimeType.split('/');

  request.files.add(
    await http.MultipartFile.fromPath(
      fieldName,
      file.path,
      contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
    ),
  );

  final streamedResponse = await request.send();
  return await http.Response.fromStream(streamedResponse);
}
}
