import 'package:flutter/material.dart';
import 'package:photo_manager/providers/fetch_images.dart';
import 'package:provider/provider.dart';
import '../screens/all_photos.dart';

class GalleryView extends StatefulWidget {
  static String routeName = '/galleryView';

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  /* bool isInit = true;
  bool isLoading = false; */

  /* @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });

      Provider.of<FetchImages>(context).SetImages(false).then((value) {
        // fetching all the images
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  } */

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FetchImages>(context);

    final isLoading = ModalRoute.of(context)!.settings.arguments as bool;
    // to check fetching images done or not already called didChangeDependencies there in photoGrid file

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => provider.setImages(true),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                // with fixed amount of space taken per grid
                childAspectRatio: 2 / 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 2,
              ),
              itemBuilder: (ctx, index) => provider.items.isEmpty
                  ? AllPhotos(null)
                  : AllPhotos(provider.items[index]),
              itemCount: provider.items.length,
            ),
    );
  }
}
