import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:same_day_delivery_client/services/location.dart';

class LocationSelector extends StatefulWidget {
  final Function(GeoPoint) onLocationSelected;
  const LocationSelector({
    super.key,
    required this.onLocationSelected,
  });

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        LocationService locationService = LocationService();
        final position = await locationService.getLocation();

        final geopoint = await showSimplePickerLocation(
          radius: 10,
          context: context,
          isDismissible: true,
          title: "Select Location",
          textConfirmPicker: "Pick",
          initPosition: GeoPoint(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
          zoomOption: const ZoomOption(
            minZoomLevel: 8,
            maxZoomLevel: 19,
            stepZoom: 1,
          ),
        );
        if (geopoint != null) {
          widget.onLocationSelected(geopoint);
        }
      },
      child: Image.asset(
        "assets/images/map.jpg",
        width: 160,
      ),
    );
  }
}
