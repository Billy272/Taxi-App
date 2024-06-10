import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(1.2921, 36.8219),
    zoom: 11.5,
  );

  late GoogleMapController _googleMapController;
  late Marker _origin;
  late Marker _destination;
  late Directions _info;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Taxi App'),
          actions: [
            if (_origin != null)
              TextButton(
                onPressed: ()  => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                  target: _origin.position,
                  zoom: 14.5,
                  tilt: 50.0,
                  ),
                ),
              ),
            style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
                backgroundColor: const Color.fromARGB(255, 0, 0, 55),
          ),
          if (_destination != null)
            TextButton(
              onPressed: ()  => _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: _destination.position,
                  zoom: 14.5,
                  tilt: 50.0,
                ),
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.greenAccent, backgroundColor: const Color.fromARGB(255, 0, 0, 55)
            ),
            ]
            ),
      body: Stack(
            alignment: Alignment.center,
            children: <Widget>[GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition ,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: {
          if (_origin != null) _origin,
          if (_destination != null) _destination,
        },
        polylines: {
          if (_info != null){
            Polyline(
              polylineId: const PolylineId('overview_polyline'),
              color: Colors.blueAccent,
              width: 5,
              points: _info.polylineCoordinates
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList(),
            ),
          },
    }
    }
        onLongPress: _addMarker,
      ),
      if (_info == null) {
        Positioned(
          top: 20.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 55),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Text(
              '${_info.totalDistance}, ${_info.totalDuration}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
    ),
          ),
        )
    }
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 0, 55),
        foregroundColor: Colors.white,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    ],
    ),
    );
  }
  void _addMarker (LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        _destination = null;

        _info = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
      });

      final directions = await Directions() .getDirections(
        origin: _origin.position,
        destination: _destination.position,
      );
      setState(() => _info = directions);
    }
  }
}



