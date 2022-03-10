import 'package:flutter/material.dart';
import 'package:photo_manager/providers/fetch_images.dart';
import 'package:provider/provider.dart';
import '../widgets/all_photos.dart';

class GalleryView extends StatelessWidget {
  static String routeName = '/galleryView';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FetchImages>(context);

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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // with fixed amount of space taken per grid
          childAspectRatio: 2 / 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
        ),
        itemBuilder: (ctx, index) => AllPhotos(provider.items[index]),
        itemCount: provider.items.length,
      ),
    );
  }
}
