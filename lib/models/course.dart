/// A bookable course mapped from an external product API response.
class Course {
  /// Creates a course with catalog fields.
  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  /// Stable identifier from the API (stringified if numeric).
  final String id;

  /// Display name of the course.
  final String title;

  /// Short or long description text.
  final String description;

  /// Network URL for course artwork.
  final String imageUrl;

  /// Parses a JSON object from the Fake Store products API.
  ///
  /// [json] Raw map from the products list endpoint.
  /// Returns a [Course] with safe defaults for missing fields.
  factory Course.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? '';
    return Course(
      id: id,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      imageUrl: json['image']?.toString() ?? '',
    );
  }
}
