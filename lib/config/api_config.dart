/// Central configuration for external REST API base URLs.
class ApiConfig {
  ApiConfig._();

  /// Base URL for product/course catalog (Fake Store API demo).
  static const String productsBaseUrl = 'https://fakestoreapi.com';

  /// Base URL for registration submission (JSONPlaceholder demo).
  static const String registrationBaseUrl = 'https://jsonplaceholder.typicode.com';

  /// Full path to list products used as courses.
  static Uri get productsUri => Uri.parse('$productsBaseUrl/products');

  /// Full path to submit registration payload.
  static Uri get registrationUri =>
      Uri.parse('$registrationBaseUrl/posts');
}
