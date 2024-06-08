import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng? _currentPosition;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _loading = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _loading = false;
        });
        return;
      }
      if (permission == LocationPermission.denied) {
        setState(() {
          _loading = false;
        });
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxi App'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 50),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _currentPosition == null
          ? const Center(child: Text('Location Services denied'))
          : FlutterMap(
        options: MapOptions(
          initialCenter: _currentPosition!,
          minZoom: 13.0,
        ),
        // layers: [
        //   TileLayer(
        //     urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        //     subdomains: const ['a', 'b', 'c'],
        //   ),
        //   MarkerLayer(
        //     markers: [
        //       Marker(
        //         width: 80.0,
        //         height: 80.0,
        //         point: _currentPosition!, child: const Icon(Icons.location_on, size: 50, color: Colors.red),
        //         // builder: (ctx) => const Icon(
        //         //   Icons.location_on,
        //         //   size: 50,
        //         //   color: Colors.red,
        //         // ),
        //       ),
        //     ],
        //   ),
        // ],
        children: const [],
      ),
    );
  }
}
