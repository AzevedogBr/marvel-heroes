import 'dart:convert';
import 'package:http/http.dart' as http;
import 'http_interceptor.dart';

class HttpClient {
  final String baseUrl = 'https://gateway.marvel.com:443';
  final HttpInterceptor _authInterceptor;

  HttpClient({required String publicKey, required String privateKey})
      : _authInterceptor = HttpInterceptor(publicKey: publicKey, privateKey: privateKey);

  Future<http.Response> get(String path, [Map<String, String>? queryParameters]) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: {
      ...?queryParameters,
      ..._authInterceptor.addAuthParams(),
    });
    return await http.get(uri);
  }

  Future<http.Response> post(String path, [dynamic data, Map<String, String>? queryParameters]) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: {
      ...?queryParameters,
      ..._authInterceptor.addAuthParams(),
    });
    return await http.post(uri, body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  }

  Future<http.Response> put(String path, [dynamic data, Map<String, String>? queryParameters]) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: {
      ...?queryParameters,
      ..._authInterceptor.addAuthParams(),
    });
    return await http.put(uri, body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  }

  Future<http.Response> delete(String path, [Map<String, String>? queryParameters]) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: {
      ...?queryParameters,
      ..._authInterceptor.addAuthParams(),
    });
    return await http.delete(uri);
  }
}