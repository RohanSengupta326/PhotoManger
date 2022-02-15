import 'package:flutter/material.dart';
import 'package:photo_manager/widgets/photo_grid.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  String imageUrl = "";

  void imageUploader() async {
    try {
      setState(() {
        _isLoading = true;
      });

      XFile? _imageFile;
      final picker = ImagePicker();

      _imageFile = await picker.pickImage(source: ImageSource.gallery);

      final filename = basename(_imageFile!.path);

      final ref = FirebaseStorage.instance.ref('clicked_images/$filename');

      final task = await ref.putFile(File(_imageFile.path));

      imageUrl = await task.ref.getDownloadURL();

      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (err) {
      setState(
        () {
          _isLoading = false;
        },
      );
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: imageUploader,
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
      body: PhotoGrid(imageUrl, _isLoading),
    );
  }
}
