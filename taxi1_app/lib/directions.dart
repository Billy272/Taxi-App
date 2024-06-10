import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:taxi1_app/.env.dart';
import 'package:flutter/foundation.dart';

class Directions{
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;
  Directions(this._dio);

  Future<dynamic> getDirections({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '$originLat,$originLng',
        'destination': '$destinationLat,$destinationLng',
        'key': googleApiKey,
      },
    );
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }
}