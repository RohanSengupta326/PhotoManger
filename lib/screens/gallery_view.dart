import 'package:flutter/material.dart';

class GalleryView extends StatelessWidget {
  static String routeName = '/galleryView';
  final void Function(BuildContext ctx) imageUploader;
  GalleryView(this.imageUploader);

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
      body: Center(child: Text('GalleryView')),
    );
  }
}
