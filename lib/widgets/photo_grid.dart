import 'package:flutter/material.dart';

class PhotoGrid extends StatefulWidget {
  final imageUrl;
  final isLoading;
  PhotoGrid(this.imageUrl, this.isLoading);

  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? CircularProgressIndicator()
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
                        image: widget.imageUrl != ""
                            ? NetworkImage(
                                widget.imageUrl,
                              ) as ImageProvider<Object>
                            : const AssetImage('assets/images/temp.jpeg'),
                      ),
                    ),
                    child: GridTile(
                      child: GestureDetector(
                        onTap: () {},
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
          );
  }
}
