import 'package:flutter/material.dart';
import 'package:photo_manager/providers/fetch_images.dart';
import 'package:photo_manager/screens/all_photos.dart';
import 'package:photo_manager/widgets/gallery_view.dart';
import '../screens/home.dart';

import 'package:provider/provider.dart';
import 'widgets/view.dart';

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
    final ThemeData theme = ThemeData();
    return MultiProvider(
      // to use multiple providers
      providers: [
        ChangeNotifierProvider(
          // Connecting the provider
          create: (ctx) => FetchImages(),
          // instance of the provider class = FetchImages class
        ),
      ],
      child: MaterialApp(
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
        home: HomeScreen(),
        routes: {
          GalleryView.routeName: (ctx) => GalleryView(),
          View.routename: (ctx) => View(),
        },
      ),
    );
  }
}
