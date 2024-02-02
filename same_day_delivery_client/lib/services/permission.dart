import 'package:permission_handler/permission_handler.dart';

enum PermissionGroup {
  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - Always
  locationAlways,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  locationWhenInUse
}

Future<bool> requestLocationPermission() async {
  var status = await Permission.location.status;
  if (status.isGranted) {
    return true;
  } else {
    var result = await Permission.location.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}

Future<bool> checkLocationPermission() async {
  var status = await Permission.location.status;
  if (status.isGranted) {
    return true;
  } else {
    return false;
  }
}
