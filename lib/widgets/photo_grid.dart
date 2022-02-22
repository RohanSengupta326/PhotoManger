import 'package:flutter/material.dart';
import 'dart:io';

import 'package:photo_manager/screens/gallery_view.dart';

class PhotoGrid extends StatefulWidget {
  final File? image;

  final void Function(BuildContext ctx) imageUploader;
  PhotoGrid(this.image, this.imageUploader);

  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
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
                  image: widget.image != null
                      ? FileImage(
                          widget.image as File,
                        ) as ImageProvider<Object>
                      : const AssetImage('assets/images/temp.jpeg'),
                ),
              ),
              child: GridTile(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => GalleryView(widget.imageUploader),
                    ),
                  ),
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
