import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:great_places/models/places_model.dart';
import 'package:logger/logger.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/services.dart';

class AddMapLocationScreen extends StatefulWidget {
  static const namedRoute = '/add-location';
  static PlaceLocation defaultPlaceLocation() => PlaceLocation(
        longitude: -122.085749655962,
        latitude: 37.42796133580664,
      );

  final PlaceLocation placeLocation;
  final bool isViewOnly;

  AddMapLocationScreen({
    super.key,
    PlaceLocation? placeLocation,
    this.isViewOnly = false,
  }) : placeLocation = placeLocation ?? defaultPlaceLocation();

  @override
  State<AddMapLocationScreen> createState() => _AddMapLocationScreenState();
}

class _AddMapLocationScreenState extends State<AddMapLocationScreen> {
  late CameraPosition _initialCameraPosition;
  late MapboxMapController _mapboxMapController;
  bool _isSelecting = false;
  LatLng? _selectedCoords;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(
      target:
          LatLng(widget.placeLocation.latitude, widget.placeLocation.longitude),
      zoom: 15,
    );
  }

  // Future<Uint8List> loadMarkerImage() async {
  //   ByteData byteData = await rootBundle.load('assets/icons/food.png');
  //   return byteData.buffer.asUint8List();
  // }

  // _addSymbolToSymbol(LatLng cords) {
  //   return _mapboxMapController.addSymbol(SymbolOptions(
  //     geometry: cords,
  //     iconImage: 'foodMarker',
  //     iconSize: .2,
  //     iconAnchor: 'bottom',
  //   ));
  // }

  _onMapCreated(MapboxMapController controller) async {
    _mapboxMapController = controller;
    // final markerImage = await loadMarkerImage();
    // _mapboxMapController.addImage('foodMarker', markerImage);

    // await _addSymbolToSymbol(_initialCameraPosition.target);
    if (widget.isViewOnly) {
      // print('in view circe');
      // print(widget.placeLocation.latitude);
      // print(_initialCameraPosition.target);

      final addCircle = await _mapboxMapController.addCircle(CircleOptions(
        geometry: LatLng(
          widget.placeLocation.latitude,
          widget.placeLocation.longitude,
        ),
        circleColor: '#19a7ce',
        circleRadius: 6,
        circleStrokeColor: '#146c94',
        circleStrokeWidth: 1,
      ));
      print('adadsda $addCircle');
    }
  }

  // @override
  // void dispose() {
  //   _mapboxMapController.dispose();
  //   // _initialCameraPosition.
  //   super.dispose();
  // }

  void _updateSelectedLocation(double latitude, double longitude) {
    setState(() {
      _isSelecting = true;
      _selectedCoords = LatLng(latitude, longitude);
      // print('in setstate');
      _initialCameraPosition = CameraPosition(
        target: _selectedCoords!,
        zoom: 15,
      );

      // _mapboxMapController.updateSymbol(
      //     Symbol('foodMarker', SymbolOptions.defaultOptions),
      //     SymbolOptions(geometry: _selectedCoords!));
      // _mapboxMapController.removeCircle();
    });
    _mapboxMapController.clearCircles();
    _mapboxMapController.addCircle(CircleOptions(
      geometry: _selectedCoords!,
      circleColor: '#19a7ce',
      circleRadius: 6,
      circleStrokeColor: '#146c94',
      circleStrokeWidth: 1,
    ));
    _mapboxMapController.animateCamera(
      CameraUpdate.newCameraPosition(_initialCameraPosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Location'),
        actions: [
          if (!widget.isViewOnly && _selectedCoords != null)
            IconButton(
              onPressed: _selectedCoords == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_selectedCoords);
                    },
              icon: const Icon(Icons.check),
            ),
          // if (widget.isViewOnly)
          //   IconButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     icon: const Icon(Icons.close_rounded),
          //   ),
        ],
      ),
      body: MapboxMap(
        zoomGesturesEnabled: true,
        accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: _onMapCreated,
        // onMapCreated: (controller) async {
        //   final markerImage = await loadMarkerImage();
        //   _mapboxMapController.addImage('foodMarker', markerImage);

        //   await _addSymbolToSymbol(_initialCameraPosition.target);
        // },
        myLocationEnabled: widget.isViewOnly ? false : !_isSelecting,
        myLocationTrackingMode: MyLocationTrackingMode.Tracking,
        minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
        onMapClick: (point, coordinates) {
          if (!widget.isViewOnly) {
            _updateSelectedLocation(
                coordinates.latitude, coordinates.longitude);
          }
        },
      ),
    );
  }
}
