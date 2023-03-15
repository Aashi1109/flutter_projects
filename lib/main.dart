import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

import './providers/great_places.dart';
import './screens/add_place_screen.dart';
import './screens/places_list_screen.dart';
import './screens/add_map_location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");
  final logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      printEmojis: true,
      printTime: false,
    ),
  );
  Logger.level = Level.warning;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlacesProviderModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amber),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 18,
            ),
            bodyMedium: TextStyle(
              fontSize: 15,
            ),
            // titleMedium: TextStyle(
            //   fontSize: 20,
            //   fontWeight: FontWeight.bold,
            // ),
            titleLarge: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // home: AddMapLocationScreen(),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.namedRoute: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.namedRoute: (ctx) => PlaceDetailScreen(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AddMapLocationScreen.namedRoute:
              final routeArgs = settings.arguments as Map<String, dynamic>?;

              return MaterialPageRoute(
                  builder: (context) => routeArgs == null
                      ? AddMapLocationScreen()
                      : AddMapLocationScreen(
                          placeLocation: routeArgs?['placeLocation'],
                          isViewOnly: routeArgs?['isViewOnly'],
                        ),
                  fullscreenDialog: true);
          }
        },
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
