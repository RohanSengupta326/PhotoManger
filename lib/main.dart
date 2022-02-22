import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String imageUrl = '';

  String progress = '';

  File? file;

  void imageUploader(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    _picker
        .pickImage(source: ImageSource.gallery)
        .then((XFile? clickedImage) async {
      if (clickedImage != null) {
        file = File(clickedImage.path);

        String fileName = file!.path.split('/').last;
        // extracted the filename from the total path of the file

        Directory appDocumentsDirectory =
            await getApplicationDocumentsDirectory();
        // gets the directory where everything will be saved
        String appDocumentsPath = appDocumentsDirectory.path;
        imageUrl = '$appDocumentsPath/$fileName';
        // to remove an extra slash from the beginning
        // print(imageUrl);
        setState(() {
          progress = 'Image Saved!';
        });
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(progress)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      title: 'photoManager',
      theme: ThemeData().copyWith(
        brightness: Brightness.dark,
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.white,
        ),
      ),
      home: HomeScreen(file, imageUploader),
    );
  }
}
