import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place_location.dart';
import 'package:great_places/providers/grate_places.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _placeLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void selectPlace({required double lat, required double lng}) {
    _placeLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _placeLocation == null) {
      return;
    }

    Provider.of<GratePlaces>(context, listen: false).addPlace(
      title: _titleController.text,
      image: _pickedImage!,
      location: _placeLocation!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 10.0),
                    ImageInput(onSelectImage: _selectImage),
                    const SizedBox(height: 10),
                    LocationInput(selectPlace: selectPlace)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: Theme.of(context).colorScheme.inverseSurface,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              )),
        ],
      ),
    );
  }
}
