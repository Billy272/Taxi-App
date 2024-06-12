import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylineCoordinates;
  final String totalDistance;
  final String totalDuration;

  Directions({
    required this.bounds,
    required this.polylineCoordinates,
    required this.totalDistance,
    required this.totalDuration,
  });



  factory Directions.fromMap(Map<String, dynamic> map) {
    final routes = map['routes'];
    final data = routes[0];
    final legs = data['legs'];
    final leg = legs[0];

    return Directions(
      bounds: LatLngBounds(
        southwest: LatLng(
          leg['start_location']['lat'],
          leg['start_location']['lng'],
        ),
        northeast: LatLng(
          leg['end_location']['lat'],
          leg['end_location']['lng'],
        ),
      ),
      totalDistance: leg['distance']['text'],
      totalDuration: leg['duration']['text'],
      polylineCoordinates:
          _decodePoly(overviewPolyline: data['overview_polyline']['points']),
    );
  }
}

_decodePoly({required overviewPolyline}) {
}