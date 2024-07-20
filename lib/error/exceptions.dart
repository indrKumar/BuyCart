class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}
class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);
}
