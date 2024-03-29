import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../screens/wrapper.dart';

class ViewPhoto extends StatelessWidget {
  static String routename = "/view";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String photoPath = args['path'];
    final File preview = args['file'];
    final String baseName = basename(photoPath);

    return FullScreenPage(
      child: preview,
      basename: baseName,
    );
  }
}
