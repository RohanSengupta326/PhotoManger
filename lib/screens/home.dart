import 'package:flutter/material.dart';
import 'package:photo_manager/widgets/photo_grid.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String imageUrl = '';
  String progress = '';

  void imageUploader(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    _picker
        .pickImage(source: ImageSource.gallery)
        .then((XFile? clickedImage) async {
      if (clickedImage != null) {
        File file = File(clickedImage.path);
        String fileName = file.path.split('/').last;
        // extracted the filename from the total path of the file

        Directory appDocumentsDirectory =
            await getApplicationDocumentsDirectory();
        // gets the directory where everything will be saved
        String appDocumentsPath = appDocumentsDirectory.path;
        imageUrl = '$appDocumentsPath/$fileName'.substring(1, imageUrl.length);
        // to remove an extra slash from the beginning

        setState(() {
          progress = 'Image Saved!';
        });
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(progress)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => imageUploader(context),
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
        backgroundColor: Colors.black,
        title: const Text(
          'Photo Manager',
        ),
      ),
      body: PhotoGrid(imageUrl),
    );
  }
}
