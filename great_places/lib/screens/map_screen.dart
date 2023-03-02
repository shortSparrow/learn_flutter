import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place_location.dart';

class MapScreenArguments {
  final PlaceLocation? initialLocation;
  final bool isSelecting;

  MapScreenArguments({
    this.initialLocation,
    this.isSelecting = false,
  });
}

class MapScreen extends StatefulWidget {
  static const routeName = '/map';
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen({
    super.key,
    this.isSelecting = false,
    PlaceLocation? initialLocation,
  }) : initialLocation = initialLocation ??
            const PlaceLocation(longitude: 30.5234, latitude: 50.4501);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation != null
                  ? () => Navigator.of(context).pop(_pickedLocation)
                  : null,
              icon: const Icon(Icons.check),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.initialLocation.latitude,
                        widget.initialLocation.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
