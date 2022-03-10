import 'package:flutter/material.dart';
import 'dart:io';

class AllPhotos extends StatelessWidget {
  final File photo;
  AllPhotos(this.photo);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      // just like listTile
      child: GestureDetector(
        onTap: () {},
        child: Image.file(
          photo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
