import 'package:flutter/material.dart';
import 'dart:io';
import '../widgets/view.dart';

class AllPhotos extends StatelessWidget {
  final File? photo;

  AllPhotos(this.photo);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      // just like listTile
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ViewPhoto.routename,
              arguments: {'path': photo!.path, 'file': photo});
        },
        child: photo == null
            ? Image.asset('assets/images/temp.jpeg')
            : Image.file(
                photo as File,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
