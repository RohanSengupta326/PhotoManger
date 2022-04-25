import 'package:flutter/material.dart';
import 'dart:io';
import '../widgets/view.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AllPhotos extends StatelessWidget {
  final File? photo;

  AllPhotos(this.photo);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      // just like listTile
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(View.routename,
              arguments: {'path': photo!.path, 'file': photo});
        },
        child: photo == null
            ? Image.asset('assets/images/temp.jpeg')
            : CarouselSlider(
                items: [
                  Image.file(
                    photo as File,
                    fit: BoxFit.cover,
                  ),
                ],
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8,
                ),
              ),
      ),
    );
  }
}
