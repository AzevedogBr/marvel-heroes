class NetworkException implements Exception {
  @override
  String toString() {
    return 'Falha na conexão com a rede.';
  }
}