class ServerException implements Exception {
  final dynamic error;

  ServerException(this.error);

  @override
  String toString() {
    return 'ServerException: $error';
  }
}
