import 'package:dio/dio.dart';
import 'package:taxi1_app/direction_model.dart';

class DirectionsRepo{
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepo(this._dio);

  Future<Directions> getDirections({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '$originLat,$originLng',
        'destination': '$destLat,$destLng',
        'key': 'AIzaSyCN9-ADDxksqVAzXKT6qr2QgM3HuMTAXlQ',
      },
    );

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    } else {
      throw Exception('Failed to load directions');
    }

  }
}