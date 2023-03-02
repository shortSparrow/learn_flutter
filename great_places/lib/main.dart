import 'package:flutter/material.dart';
import 'package:great_places/providers/grate_places.dart';
import 'package:great_places/screens/places_screen_list.dart';
import 'package:provider/provider.dart';

import 'navigation/onGenerateRoute.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      // create: (BuildContext context) => GratePlaces(),
      value: GratePlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amber),
        ),
        home: const PlacesListScreen(),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
