import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';

class FetchImages with ChangeNotifier {
  List<File> _imagesList = [];

  List<File> get items {
    return [..._imagesList];
  }

  Future<void> setImages(bool camera) async {
    if (camera) {
      final ImagePicker _picker = ImagePicker();
      _picker.pickImage(source: ImageSource.gallery).then(
        (XFile? clickedImage) async {
          if (clickedImage != null) {
            Directory appDocumentsDirectory =
                await getApplicationDocumentsDirectory();
            // gets the directory where everything will be saved
            String appDocumentsPath = appDocumentsDirectory.path;
            String v4 = Uuid().v4();
            // random id generator, using cz else same named file problem occuring
            final String newPath = '$appDocumentsPath/$v4.png';

            final File newImage = await File(clickedImage.path).copy(newPath);

            _imagesList.add(newImage);
            // image sets in the list after clicking, now fetching list I can fetch the images and
            //show them
            notifyListeners();
          }
        },
      );
    } else {
      // if not taking image just fetching images
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String appDocumentsPath = appDocumentsDirectory.path;

      final Directory _photoDir = Directory(appDocumentsPath);
      // got the directory where all the photos are

      List<dynamic> imageList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith('.png'))
          .toList();
      // in a new list I put all the path of images in the directory

      if (imageList.isEmpty) {
        _imagesList = [];
        notifyListeners();
        return;
      } else {
        for (int i = 0; i < imageList.length; i++) {
          // imageList[i] = File(imageList[i] as String);
          _imagesList.add(File(imageList[i]));
        }
      }

      // in my main list, I put every File by converting it with File(path)
      // now Ive got all the images in my main list
      // fetch it to preview it all
      notifyListeners();
    }
  }

  Future<void> deleteImage(String fileName) async {
    final toDeleteIndex = _imagesList.indexWhere(
      (element) {
        String baseName = basename(element.path);
        return baseName == fileName;
      },
    );

    File? backupImage = _imagesList[toDeleteIndex];

    _imagesList.removeAt(toDeleteIndex);

    notifyListeners();

    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    final File toDeleteFile = File("$appDocumentsPath/$fileName");

    try {
      await toDeleteFile.delete();
      // to delete file from phone storage
    } catch (error) {
      _imagesList[toDeleteIndex] = backupImage;
    }

    backupImage = null;
    // deleted properly
  }
}
