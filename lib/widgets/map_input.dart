import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart' show LatLng;
import 'package:location/location.dart';

import 'package:great_places/helpers/mapbox_helper.dart';
import 'package:great_places/screens/add_map_location.dart';

class MapInput extends StatefulWidget {
  final Function setLocation;
  const MapInput(this.setLocation, {super.key});

  @override
  State<MapInput> createState() => _MapInputState();
}

class _MapInputState extends State<MapInput> {
  Map<String, double>? _latLong;

  Future<void> _getUserCurrentLocation() async {
    final cords = await Location().getLocation();

    if (cords == null) return;

    setState(() {
      // print(MapBoxHelper.getStaticMapUrl(cords.latitude!, cords.longitude!));
      _latLong = {
        'latitude': cords.latitude!,
        'longitude': cords.longitude!,
      };

      widget
          .setLocation(LatLng(_latLong!['latitude']!, _latLong!['longitude']!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_latLong != null)
          Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Image.network(
                MapBoxHelper.getStaticMapUrl(
                  _latLong!['latitude']!,
                  _latLong!['longitude']!,
                ),
                fit: BoxFit.cover,
                width: double.infinity,
              )
              // : const Text(
              //     'No location chosen',
              //     textAlign: TextAlign.center,
              //   ),
              ),
        const SizedBox(
          height: 10,
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              label: const Text('Add Current location'),
              onPressed: _getUserCurrentLocation,
              icon: Icon(
                Icons.add_location_alt_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            TextButton.icon(
              label: const Text('Choose location on map'),
              onPressed: () async {
                LatLng? selectedCoords = await Navigator.of(context).pushNamed(
                  AddMapLocationScreen.namedRoute,
                );
                //     .then<LatLng>((value) {
                //   // Logger().d(value);
                //   print(value);
                //   return value as LatLng;
                // });

                // print(selectedCoords);
                if (selectedCoords == null) return;

                setState(() {
                  _latLong = {
                    'latitude': selectedCoords.latitude,
                    'longitude': selectedCoords.longitude,
                  };
                });
                widget.setLocation(
                    LatLng(_latLong!['latitude']!, _latLong!['longitude']!));
              },
              icon: Icon(
                Icons.map_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        )
      ],
    );
  }
}
