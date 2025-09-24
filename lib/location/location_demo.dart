import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_helper.dart';

class LocationDemo extends StatefulWidget {
  const LocationDemo({super.key});

  @override
  State<LocationDemo> createState() => _LocationDemoState();
}

class _LocationDemoState extends State<LocationDemo> {
  String _currentCoords = "Not fetched";
  String _currentAddress = "Not fetched";
  String _liveCoords = "Not started";
  String _searchedCoords = "Not searched";
  String _searchedAddress =
      "Simandhar Plaza, near, Janta Nagar Rd, Ghatlodiya, Ahmedabad, Gujarat 380061";

  Stream<Position>? _positionStream;

  @override
  void initState() {
    super.initState();
  }

  /// 1️⃣ Fetch current location (one time)
  Future<void> _getCurrentLocation() async {
    final position = await LocationHelper.getCurrentPosition();
    if (position != null) {
      final address = await LocationHelper.getAddressFromLatLng(
        position.latitude,
        position.longitude,
      );
      setState(() {
        _currentCoords =
            "Lat: ${position.latitude}, Lng: ${position.longitude}";
        _currentAddress = address ?? "Address not found";
      });
    }
  }

  /// 2️⃣ Start live location updates
  void _startLiveLocation() {
    _positionStream = LocationHelper.getLiveLocation();
    _positionStream?.listen((pos) async {
      final address = await LocationHelper.getAddressFromLatLng(
        pos.latitude,
        pos.longitude,
      );
      setState(() {
        _liveCoords = "Lat: ${pos.latitude}, Lng: ${pos.longitude}";
        _currentAddress = address ?? "Address not found";
      });
    });
  }

  /// 3️⃣ Convert address → latLng
  Future<void> _addressToLatLng() async {
    final pos = await LocationHelper.getLatLngFromAddress(
      "Simandhar Plaza, near, Janta Nagar Rd, Ghatlodiya, Ahmedabad, Gujarat 380061",
    );
    if (pos != null) {
      setState(() {
        _searchedCoords = "Lat: ${pos.latitude}, Lng: ${pos.longitude}";
        _searchedAddress =
            "Simandhar Plaza, near, Janta Nagar Rd, Ghatlodiya, Ahmedabad, Gujarat 380061";
      });
    }
  }

  /// 4️⃣ Convert latLng → address
  Future<void> _latLngToAddress() async {
    const double lat = 23.0687;
    const double lng = 72.5398;
    final address = await LocationHelper.getAddressFromLatLng(lat, lng);
    setState(() {
      _searchedCoords = "Lat: $lat, Lng: $lng";
      _searchedAddress = address ?? "Address not found";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Demo")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "1️⃣ Current Location:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Coords: $_currentCoords"),
            Text("Address: $_currentAddress"),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text("Get Current Location"),
            ),
            const Divider(),

            const Text(
              "2️⃣ Live Location:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Coords: $_liveCoords"),
            ElevatedButton(
              onPressed: _startLiveLocation,
              child: const Text("Start Live Location"),
            ),
            const Divider(),

            const Text(
              "3️⃣ Address → LatLng:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Coords: $_searchedCoords"),
            Text("From Address: $_searchedAddress"),
            ElevatedButton(
              onPressed: _addressToLatLng,
              child: const Text("Search Address (Statue of Unity)"),
            ),
            const Divider(),

            const Text(
              "4️⃣ LatLng → Address:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Coords: $_searchedCoords"),
            Text("Address: $_searchedAddress"),
            ElevatedButton(
              onPressed: _latLngToAddress,
              child: const Text("Search LatLng (21.8380, 73.7191)"),
            ),
          ],
        ),
      ),
    );
  }
}
