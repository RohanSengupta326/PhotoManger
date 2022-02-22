import 'package:flutter/material.dart';
import 'package:photo_manager/widgets/photo_grid.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  final File? image;
  final void Function(BuildContext ctx) imageUploader;
  HomeScreen(this.image, this.imageUploader);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => widget.imageUploader(context),
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
      body: PhotoGrid(widget.image, widget.imageUploader),
    );
  }
}
