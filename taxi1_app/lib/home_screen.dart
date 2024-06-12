import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:taxi1_app/.env.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:taxi1_app/direction_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  late LatLng _lastMapPosition = _initialCameraPosition.target;
  final Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(-1.2921, 36.8219),
    zoom: 11.5,
  );

  late LatLng _origin;
  LatLng? _destination;

  @override
  void initState() {
    super.initState();
    _setOriginToCurrentLocation();
  }

  void _setOriginToCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _origin = LatLng(position.latitude, position.longitude);
      _markers.add(Marker(
        markerId: const MarkerId('origin'),
        position: _origin,
        infoWindow: const InfoWindow(
          title: 'Origin',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ));
      _lastMapPosition = _origin;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onTap(LatLng position) {
    _onAddOriginMarkerButtonPressed(position);
  }

  void _onLongPress(LatLng position) {
    _onAddDestinationMarkerButtonPressed(position);
    _addPath();
  }

  void _onAddOriginMarkerButtonPressed(LatLng position) {
    setState(() {
      _origin = position;
      _markers.add(Marker(
        markerId: const MarkerId('origin'),
        position: _origin,
        infoWindow: const InfoWindow(
          title: 'Origin',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ));
    });
  }

  void _onAddDestinationMarkerButtonPressed(LatLng position) {
    setState(() {
      _destination = position;
      _markers.add(Marker(
        markerId: const MarkerId('destination'),
        position: _destination!,
        infoWindow: const InfoWindow(
          title: 'Destination',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
      _addPath();
    });
  }

  void _addPath() async {
    if (_origin == null || _destination == null) return;

    polylineCoordinates.clear();
    _polylines.clear();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(_origin.latitude, _origin.longitude),
      PointLatLng(_destination!.latitude, _destination!.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      setState(() {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });

        Polyline polyline = Polyline(
          polylineId: const PolylineId('poly'),
          color: Colors.blue,
          points: polylineCoordinates,
          width: 5,
        );

        _polylines.add(polyline);
      });
    } else {
      print('No points found');
    }
  }

  void requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      // Permission granted
    }
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: TextEditingController(),
        googleAPIKey: googleApiKey,
        inputDecoration: const InputDecoration(
          hintText: 'Search Destination',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        debounceTime: 500,
        countries: ['ke'],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          setState(() {
            _destination = LatLng(prediction.lat, prediction.lng);
            _markers.add(Marker(
              markerId: const MarkerId('destination'),
              position: _destination!,
              infoWindow: const InfoWindow(
                title: 'Destination',
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            ));
            _addPath();
          });
        },
      )
    );
  }

  Future<void> _showTravelTime() async {
    if (_origin == null || _destination == null) return;

    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_origin.latitude},${_origin.longitude}&destination=${_destination!.latitude},${_destination!.longitude}&key=$googleApiKey';
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);

    String duration = values["routes"][0]["legs"][0]["duration"]["text"];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Estimated Travel Time'),
        content: Text('Travel time: $duration'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationButtonEnabled: true,
              markers: _markers,
              initialCameraPosition: _initialCameraPosition,
              myLocationEnabled: true,
              onTap: _onTap,
              onLongPress: _onLongPress,
              polylines: _polylines,
            ),
          ),
          Positioned(
            top: 50,
            left: 15,
            right: 15,
            child: _buildSearchBar(context),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _addPath,
            child: const Icon(Icons.directions),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _showTravelTime,
            child: const Icon(Icons.access_time),
          ),
        ],
      ),
    );
  }
}
