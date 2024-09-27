import 'dart:convert';
import 'package:crypto/crypto.dart';

class HttpInterceptor {
  final String publicKey;
  final String privateKey;

  HttpInterceptor({required this.publicKey, required this.privateKey});

  Map<String, String> addAuthParams() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateMd5('$timestamp$privateKey$publicKey');

    return {
      'apikey': publicKey,
      'ts': timestamp,
      'hash': hash,
    };
  }

  String generateMd5(String data) {
    var content = utf8.encode(data);
    var digest = md5.convert(content);
    return digest.toString();
  }
}