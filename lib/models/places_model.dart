import 'dart:io';

class PlaceLocation {
  final double longitude;
  final double latitude;
  final String? address;

  PlaceLocation({
    required this.longitude,
    required this.latitude,
    this.address,
  });
}

class Places {
  final String id;
  final String title;
  PlaceLocation? location;
  final File image;

  Places({
    required this.id,
    required this.title,
    this.location,
    required this.image,
  });
}
