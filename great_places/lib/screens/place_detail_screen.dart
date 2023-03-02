import 'package:flutter/material.dart';
import 'package:great_places/providers/grate_places.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreenArguments {
  final String id;

  PlaceDetailScreenArguments({required this.id});
}

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-details';

  final String id;

  const PlaceDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final selectedPlace =
        Provider.of<GratePlaces>(context, listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Place ${selectedPlace.title}'),
      ),
      body: Column(children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Image.file(
            selectedPlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          selectedPlace.location.address ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => Navigator.of(context).pushNamed(
            MapScreen.routeName,
            arguments: MapScreenArguments(
              initialLocation: selectedPlace.location,
              isSelecting: false,
            ),
          ),
          child: const Text('View on map'),
        )
      ]),
    );
  }
}
