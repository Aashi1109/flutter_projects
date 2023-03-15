import 'package:flutter/material.dart';

import 'package:great_places/helpers/mapbox_helper.dart';
import 'package:great_places/models/places_model.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_map_location.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const namedRoute = 'place-detail';
  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context)!.settings.arguments as String;
    // print(placeId);
    final placeData =
        Provider.of<GreatPlacesProviderModel>(context, listen: false)
            .getPlaceById(placeId);

    // print(placeData.location);
    return Scaffold(
      appBar: AppBar(title: const Text('Info')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          // Image.network(
          //   MapBoxHelper.getStaticMapUrl(
          //       placeData.location!.latitude, placeData.location!.longitude),
          //   fit: BoxFit.cover,
          //   height: 200,
          //   width: double.infinity,
          // ),
          Image.file(
            placeData.image,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                placeData.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AddMapLocationScreen.namedRoute, arguments: {
                    'isViewOnly': true,
                    'placeLocation': PlaceLocation(
                      latitude: placeData.location!.latitude,
                      longitude: placeData.location!.longitude,
                    )
                  });
                },
                icon: Icon(
                  Icons.location_pin,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          Text(placeData.location!.address!),
        ]),
      ),
    );
  }
}
