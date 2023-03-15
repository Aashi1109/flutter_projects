import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/map_input.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:mapbox_gl/mapbox_gl.dart' show LatLng;

import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const namedRoute = '/add-place';
  AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleInputController = TextEditingController();

  File? _pickedImageFile;
  LatLng? _pickedLocation;

  void _getImageFile(File pickedImage) {
    _pickedImageFile = pickedImage;
  }

  void _getSelectedLocation(LatLng location) => _pickedLocation = location;

  void _saveData() {
    if (_titleInputController.text.isEmpty ||
        _pickedImageFile == null ||
        _pickedLocation == null) {
      return;
    }

    Provider.of<GreatPlacesProviderModel>(context, listen: false).addPlaces(
      DateTime.now(),
      _titleInputController.text,
      _pickedImageFile!,
      _pickedLocation!,
    );
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    Location().getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Title'),
                        constraints: BoxConstraints(
                          maxHeight: 50,
                        ),
                      ),
                      controller: _titleInputController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(_getImageFile),
                    const SizedBox(
                      height: 10,
                    ),
                    MapInput(_getSelectedLocation),
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _saveData,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
