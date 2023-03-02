import 'package:flutter/material.dart';
import 'package:great_places/providers/grate_places.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  void _navigateToDetailScreen(BuildContext context, id) {
    Navigator.of(context).pushNamed(PlaceDetailScreen.routeName,
        arguments: PlaceDetailScreenArguments(id: id));
  }

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
      body: FutureBuilder(
        future: Provider.of<GratePlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Consumer<GratePlaces>(
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
                  subtitle:
                      Text(greatPlaces.items[index].location.address ?? ''),
                  onTap: () => _navigateToDetailScreen(
                      context, greatPlaces.items[index].id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
