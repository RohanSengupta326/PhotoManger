import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class PhotoGrid extends StatefulWidget {
  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  var _isLoading = false;
  String imageUrl = '';

  void imageUploader() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final ImagePicker _picker = ImagePicker();
      final XFile? _clickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
      final refPath = FirebaseStorage.instance
          .ref()
          .child('clicked_image')
          .child(DateTime.now().toString() + '.jpg');
      await refPath.putFile(
        // storing the image in the bucket in firebase storage
        File(_clickedImage!.path),
      );
      imageUrl = await refPath.getDownloadURL();
      // storing the url in the variable

      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (err) {
      var message = 'Sorry!, some error ocurred!';
      if (err.message != null) {
        message = err.message as String;
      }
      Scaffold.of(context).showSnackBar(
        // but this context should come from where we are showing the snackbar which is not in this file, so importing
        // with constructor
        SnackBar(
          content: Text(message),
        ),
      );
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
    return GridView.count(
      childAspectRatio: 2 / 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    imageUrl,
                  ),
                ),
              ),
              child: GridTile(
                child: GestureDetector(
                  onTap: () {},
                ),
                footer: const GridTileBar(
                  title: Center(
                    child: Text(
                      'Camera',
                    ),
                  ),
                  backgroundColor: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
