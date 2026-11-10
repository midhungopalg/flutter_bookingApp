import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/banner_item.dart';
import '../models/course.dart';
import 'api_exception.dart';

/// Fetches courses and banner items from the external product catalog API.
class CourseApiService {
  /// Creates a service using the default HTTP client.
  CourseApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  /// Loads all courses from the products endpoint.
  ///
  /// Returns a list of [Course] on HTTP 2xx.
  /// Throws [ApiException] on failure or invalid JSON.
  Future<List<Course>> fetchCourses() async {
    final response = await _client.get(ApiConfig.productsUri);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        'Failed to load courses',
        statusCode: response.statusCode,
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw ApiException('Invalid course list response');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(Course.fromJson)
        .toList();
  }

  /// Loads banner slides from the first [limit] courses.
  ///
  /// [limit] Maximum number of banners (default 2).
  /// Returns [BannerItem] list for the home carousel.
  Future<List<BannerItem>> fetchBanners({int limit = 2}) async {
    final courses = await fetchCourses();
    final slice = courses.take(limit).toList();
    return slice.map(BannerItem.fromCourse).toList();
  }
}
