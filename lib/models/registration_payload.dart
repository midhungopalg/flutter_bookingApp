/// Registration request body sent to the external booking API.
class RegistrationPayload {
  /// Creates payload with user and selected course details.
  const RegistrationPayload({
    required this.name,
    required this.mobile,
    required this.productId,
    required this.productTitle,
  });

  /// Registrant full name.
  final String name;

  /// 10-digit mobile number.
  final String mobile;

  /// Selected course/product id.
  final String productId;

  /// Selected course title for audit/display on server.
  final String productTitle;

  /// Serializes to JSON for POST body.
  ///
  /// Returns a map with stable keys for backend integration.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobile': mobile,
      'productId': productId,
      'productTitle': productTitle,
    };
  }
}
