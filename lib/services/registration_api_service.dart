import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/registration_payload.dart';
import 'api_exception.dart';

/// Submits registration/booking data to the external API.
class RegistrationApiService {
  /// Creates a service using the default HTTP client.
  RegistrationApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  /// POSTs [payload] as JSON to the registration endpoint.
  ///
  /// Returns when the server responds with HTTP 2xx.
  /// Throws [ApiException] on network or non-success status.
  Future<void> submitRegistration(RegistrationPayload payload) async {
    final response = await _client.post(
      ApiConfig.registrationUri,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(payload.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        'Registration failed',
        statusCode: response.statusCode,
      );
    }
  }
}
