import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getLocation() async {
    final status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    );
  }

  diableLocationPermission() async {
    await Geolocator.openAppSettings();
  }

  Future<Placemark?> getPlaceName(GeoPoint position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      return placemarks.first;
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  double getDistance(GeoPoint startPoint, GeoPoint endPoint) {
    double distanceInMeters = Geolocator.distanceBetween(
      startPoint.latitude,
      startPoint.longitude,
      endPoint.latitude,
      endPoint.longitude,
    );
    return distanceInMeters;
  }
}
