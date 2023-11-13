import 'package:flutter/material.dart';
import 'package:photo_manager/providers/fetch_images.dart';

import 'package:photo_manager/widgets/gallery_view.dart';
import '../screens/home.dart';

import 'package:provider/provider.dart';
import '/widgets/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Connecting the provider
      create: (ctx) => FetchImages(),
      // instance of the provider class = FetchImages class
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'photoManager',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          GalleryView.routeName: (ctx) => GalleryView(),
          ViewPhoto.routename: (ctx) => ViewPhoto(),
        },
      ),
    );
  }
}
