class AuthServerException implements Exception {
  final String message;

  AuthServerException({required this.message});

  @override
  String toString() => message;
}
