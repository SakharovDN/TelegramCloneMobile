enum ApiExceptionType { network, notVerified, notFound, wrongPassword, emailExists, validationError, other, tokenExpired }

class ApiException implements Exception {
  final ApiExceptionType type;
  ApiException(this.type);
}
