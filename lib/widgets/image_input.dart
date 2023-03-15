import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:great_places/helpers/file_helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function setImageFile;
  const ImageInput(this.setImageFile, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;
  String? _pickedImageName;
  int? _pickedImageSize;
  File? _prevFile;

  Future<void> _pickImage() async {
    // final picker = ImagePicker();
    if (_prevFile != null) {
      await _prevFile?.delete();
      print('In prev delete section');
    }

    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
    );

    if (pickedImage == null) return;

    _pickedImageSize = await pickedImage.length();

    setState(() {
      _imageFile = File(pickedImage.path);
      _pickedImageName = pickedImage.name;
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // _imageFile.
    // print(appDir);
    final fileName = path.basename(pickedImage.path);
    // print(fileName);
    final savedImage = await _imageFile?.copy('${appDir.path}/$fileName');
    widget.setImageFile(savedImage);
    _prevFile = savedImage;
    // print(savedImage);
    // print(await pickedImage!.length());
  }

  void _resetPickedImage() {
    setState(() {
      _imageFile = null;
      _pickedImageSize = null;
      _pickedImageName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _imageFile == null
            ? DottedBorder(
                color: Colors.grey,
                strokeWidth: 3,
                dashPattern: const [10, 6],
                child: Container(
                  // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(5),
                  // ),
                  height: 100,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      _pickImage();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Browse to select image',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Card(
                elevation: 3,
                // margin: ,
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 10,
                ),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    // child: Image.asset(
                    //   'assets/images/fullstack-dev.png',
                    //   fit: BoxFit.cover,
                    // ),
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    _pickedImageName!,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: Text(
                    FileHelper.formatBytes(_pickedImageSize!),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: _resetPickedImage,
                  ),
                ),
              ),
      ],
    );
  }
}
