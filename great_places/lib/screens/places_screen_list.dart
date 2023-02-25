import 'package:flutter/material.dart';
import 'package:great_places/providers/greate_places.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<GratePlaces>(
        child: const Center(
          child: Text('Got no places yet, start adding some'),
        ),
        builder: (context, greatPlaces, child) {
          if (greatPlaces.items.isEmpty) {
            return child ?? Container();
          }
          return ListView.builder(
            itemCount: greatPlaces.items.length,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(greatPlaces.items[index].image),
              ),
              title: Text(greatPlaces.items[index].title),
              onTap: () {
                
              },
            ),
          );
        },
      ),
    );
  }
}