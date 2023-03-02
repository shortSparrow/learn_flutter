import 'package:flutter/material.dart';

import '../screens/add_place_screen.dart';
import '../screens/map_screen.dart';
import '../screens/place_detail_screen.dart';

MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
  if (settings.name == AddPlaceScreen.routeName) {
    return MaterialPageRoute(
      builder: (context) {
        return const AddPlaceScreen();
      },
    );
  }

  if (settings.name == MapScreen.routeName) {
    final args = settings.arguments as MapScreenArguments;
    return MaterialPageRoute(
      builder: (context) {
        return MapScreen(
          isSelecting: args.isSelecting,
          initialLocation: args.initialLocation,
        );
      },
    );
  }
  if (settings.name == PlaceDetailScreen.routeName) {
    final args = settings.arguments as PlaceDetailScreenArguments;
    return MaterialPageRoute(
      builder: (context) {
        return PlaceDetailScreen(id: args.id);
      },
    );
  }

  return null;
}
