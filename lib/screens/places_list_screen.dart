import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../screens/add_place_screen.dart';
import './place_detail_screen.dart';

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
              Navigator.of(context).pushNamed(AddPlaceScreen.namedRoute);
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      // body: const CircularProgressIndicator(),
      body: FutureBuilder(
          future: Provider.of<GreatPlacesProviderModel>(context, listen: false)
              .fetchSetPlacesFromDb(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlacesProviderModel>(
                    builder: (context, placesProvider, child) {
                      if (placesProvider.places.isEmpty) {
                        return const Center(
                          child: Text('No places found start by adding some.'),
                        );
                      }
                      return ListView.builder(
                        itemCount: placesProvider.places.length,
                        itemBuilder: ((ctx, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(placesProvider.places[index].image),
                            ),
                            title: Text(placesProvider.places[index].title),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios_rounded),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.namedRoute,
                                    arguments: placesProvider.places[index].id);
                              },
                            ),
                          );
                        }),
                      );
                    },
                  );
          }),
    );
  }
}
