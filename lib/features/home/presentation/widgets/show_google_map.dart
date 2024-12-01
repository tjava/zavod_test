import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class ShowGoogleMap extends StatefulWidget {
  const ShowGoogleMap({super.key});

  @override
  State<ShowGoogleMap> createState() => _ShowGoogleMapState();
}

class _ShowGoogleMapState extends State<ShowGoogleMap> {
  final locationController = Location();

  static const randomPoints = [
    LatLng(37.4000, -122.1000),
    LatLng(37.3800, -122.0700),
    LatLng(37.4100, -122.0800),
    LatLng(37.3700, -122.0900),
    LatLng(37.3950, -122.1200),
    LatLng(37.3750, -122.0600),
    LatLng(37.4000, -122.0500),
  ];

  LatLng? currentPosition;
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await _fetchLocationUpdates());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: currentPosition == null
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: currentPosition!,
                  zoom: 13,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('currentLocation'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue,
                    ),
                    position: currentPosition!,
                  ),
                  for (int index = 0; index < randomPoints.length; index++)
                    Marker(
                      markerId: MarkerId('${randomPoints[index]}'),
                      icon: BitmapDescriptor.defaultMarker,
                      position: randomPoints[index],
                      onTap: () {
                        _onMarkerTapped(
                          randomPoints[index].latitude,
                          randomPoints[index].longitude,
                        );
                      },
                    ),
                },
                polylines: Set<Polyline>.of(polylines.values),
              ),
      );

  void _onMarkerTapped(double longitude, double latitude) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Latitude: $latitude",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              "Longitude: $longitude",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  _fetchRoute(latitude, longitude);
                  Navigator.pop(context);
                },
                child: const Text("Get Navigation"),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _fetchLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          currentPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
        });
      }
    });
  }

  Future<void> _fetchRoute(double longitude, double latitude) async {
    const id = PolylineId('polyline');

    final String url =
        "https://router.project-osrm.org/route/v1/driving/${currentPosition!.longitude},${currentPosition!.latitude};$longitude,$latitude";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final String encodedPolyline = data['routes'][0]['geometry'];
          final List<LatLng> routePoints = _decodePolyline(encodedPolyline);

          polylines[id] = Polyline(
            polylineId: const PolylineId("osm_route"),
            points: routePoints,
            color: Colors.blue,
            width: 5,
          );
          setState(() {});
        }
      } else {
        debugPrint("Failed to fetch route: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error fetching route: $e");
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }
}
