import 'package:flutter/material.dart';
import 'package:great_places/providers/grate_places.dart';
import 'package:great_places/screens/places_screen_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';

import 'navigation/onGenerateRoute.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  
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
