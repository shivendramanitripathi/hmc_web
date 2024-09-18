import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (kDebugMode) {
        print('Location services are disabled.');
      }
      return null;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (kDebugMode) {
          print('Location permissions are denied');
        }
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (kDebugMode) {
        print(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      return null;
    }

    // Platform-specific settings
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, // High accuracy
      distanceFilter: 10, // Minimum distance to trigger updates
    );

    // Get current location with the platform-specific settings
    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }
}
