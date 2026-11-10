import 'course.dart';

/// Banner slide content for the home page carousel.
class BannerItem {
  /// Creates a banner item with image and text overlays.
  const BannerItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  /// Identifier aligned with source course/product id.
  final String id;

  /// Primary headline on the banner.
  final String title;

  /// Secondary line (truncated description).
  final String subtitle;

  /// Background image URL.
  final String imageUrl;

  /// Builds a [BannerItem] from a [Course].
  ///
  /// [course] Source course from the catalog.
  /// Returns banner fields with a shortened subtitle.
  factory BannerItem.fromCourse(Course course) {
    final desc = course.description;
    final subtitle =
        desc.length > 80 ? '${desc.substring(0, 80)}…' : desc;
    return BannerItem(
      id: course.id,
      title: course.title,
      subtitle: subtitle,
      imageUrl: course.imageUrl,
    );
  }
}
