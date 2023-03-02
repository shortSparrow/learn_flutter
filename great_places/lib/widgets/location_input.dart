import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function({required double lat, required double lng}) selectPlace;

  const LocationInput({super.key, required this.selectPlace});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview({required double lat, required double lng}) {
    final previewUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = previewUrl;
    });
  }

  Future<void> _getUserLocation() async {
    try {
      final locationData = await Location().getLocation();
      if (locationData.latitude == null || locationData.longitude == null) {
        return;
      }
      _showPreview(lat: locationData.latitude!, lng: locationData.longitude!);
      widget.selectPlace(
        lat: locationData.latitude!,
        lng: locationData.longitude!,
      );
    } catch (e) {
      print("Failed tp get user LocationL $e");
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).pushNamed(
      MapScreen.routeName,
      arguments: MapScreenArguments(isSelecting: true),
    ) as LatLng?;

    if (selectedLocation == null) {
      return;
    }

    _showPreview(
      lat: selectedLocation.latitude,
      lng: selectedLocation.longitude,
    );
    widget.selectPlace(
      lat: selectedLocation.latitude,
      lng: selectedLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: _previewImageUrl == null ? Alignment.center : null,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text(
                  "No location choose",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: _getUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current location'),
            ),
            const SizedBox(width: 20),
            OutlinedButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        )
      ],
    );
  }
}
