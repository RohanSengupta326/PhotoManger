import 'package:flutter/material.dart';
import 'package:photo_manager/providers/fetch_images.dart';

import 'package:photo_manager/widgets/gallery_view.dart';
import 'package:provider/provider.dart';

class PhotoGrid extends StatefulWidget {
  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  bool isInit = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (isInit) {
      setState(() {
        isLoading = true;
      });

      Provider.of<FetchImages>(context).setImages(false).then((value) {
        // fetching all the images
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final latestImage = Provider.of<FetchImages>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => latestImage.setImages(true),
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
          : GridView.count(
              childAspectRatio: 2 / 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: latestImage.items.isNotEmpty
                              ? FileImage(
                                  latestImage
                                      .items[0],
                                ) as ImageProvider<Object>
                              : const AssetImage('assets/images/temp.jpeg'),
                        ),
                      ),
                      child: GridTile(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                            GalleryView.routeName,
                            arguments: isLoading,
                          ),
                        ),
                        footer: const GridTileBar(
                          title: Center(
                            child: Text(
                              'Camera',
                            ),
                          ),
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
