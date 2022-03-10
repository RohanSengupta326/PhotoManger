import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class FetchImages with ChangeNotifier {
  List<File> _imagesList = [];

  List<File> get items {
    return [..._imagesList];
  }

  int count = 0;
  Future<void> SetImages() async {
    final ImagePicker _picker = ImagePicker();
    _picker.pickImage(source: ImageSource.gallery).then(
      (XFile? clickedImage) async {
        if (clickedImage != null) {
          Directory appDocumentsDirectory =
              await getApplicationDocumentsDirectory();
          // gets the directory where everything will be saved
          String appDocumentsPath = appDocumentsDirectory.path;
          String newPath = '$appDocumentsPath/image$count.png';
          final File newImage = await File(clickedImage.path).copy(newPath);

          _imagesList.add(newImage);
          // image sets in the list after clicking, now fetching list I can fetch the images and
          //show them
        }
      },
    );
    count++;
    notifyListeners();
  }
}
