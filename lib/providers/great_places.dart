import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/helpers/mapbox_helper.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../models/places_model.dart';

class GreatPlacesProviderModel with ChangeNotifier {
  List<Places> _places = [];

  List<Places> get places {
    return [..._places];
  }

  Future<void> addPlaces(
      DateTime id, String title, File imageFile, LatLng latLng) async {
    final addressResp = await MapBoxHelper.getAddressFromLatLong(
        latLng.latitude, latLng.longitude);

    // print(resp);
    _places.add(
      Places(
        id: id.toIso8601String(),
        title: title,
        location: PlaceLocation(
            latitude: latLng.latitude,
            longitude: latLng.longitude,
            address: addressResp),
        image: imageFile,
      ),
    );
    notifyListeners();
    DbHelper.insertData(
      'Places',
      {
        'id': id.toIso8601String(),
        'title': title,
        'image': imageFile.path,
        'loc_lat': latLng.latitude,
        'loc_long': latLng.longitude,
        'address': addressResp,
      },
    );
  }

  Future<void> fetchSetPlacesFromDb() async {
    final fetchedData = await DbHelper.fetchData('Places');
    if (fetchedData == null) return;
    _places = fetchedData
        .map(
          (data) => Places(
            id: data['id'] as String,
            title: data['title'] as String,
            image: File(
              data['image'] as String,
            ),
            location: PlaceLocation(
              latitude: data['loc_lat'] as double,
              longitude: data['loc_long'] as double,
              address: data['address'] as String,
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  Places getPlaceById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }
}
