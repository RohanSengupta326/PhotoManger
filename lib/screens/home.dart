import 'package:flutter/material.dart';
import 'package:photo_manager/providers/fetch_images.dart';
import 'package:photo_manager/widgets/photo_grid.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FetchImages>(context);
    // calling the provider

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => provider.SetImages(),
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
      body: PhotoGrid(),
    );
  }
}
