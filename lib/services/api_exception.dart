/// Thrown when an HTTP API call fails or returns a non-success status.
class ApiException implements Exception {
  /// Creates an exception with a human-readable [message].
  ApiException(this.message, {this.statusCode});

  /// Error description for UI or logging.
  final String message;

  /// HTTP status when available.
  final int? statusCode;

  @override
  String toString() => 'ApiException: $message';
}
