import 'package:flutter/material.dart';
import 'package:photo_manager/providers/fetch_images.dart';
import '../widgets/sliding_appBar.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class FullScreenPage extends StatefulWidget {
  FullScreenPage({
    required this.child,
    required this.basename,
  });

  final File child;
  final String basename;

  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage>
    with SingleTickerProviderStateMixin {
  /* @override
  void initState() {
    var brightness = Brightness.dark;
    var color = Colors.black12;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    // to hide bars(not appbar) from top and bottom
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: color,
      statusBarColor: color,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
      systemNavigationBarDividerColor: color,
      systemNavigationBarIconBrightness: brightness,
    ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    // to reshow the bars
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // Restore your settings here...
        ));
    super.dispose();
  } */

  bool _visible = true;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // need "with SingleTickerProviderStateMixin"
      duration: Duration(milliseconds: 400),
    );
  }

  Future<void> _shareImage() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;

    String fileName = widget.basename;

    String path = "$appDocumentsPath/$fileName";
    await Share.shareFiles([path]);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FetchImages>(context);
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: SlidingAppBar(
        // to remove and reshow appbar
        controller: _controller,
        visible: _visible,
        child: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                // ask before delete
                bool deleteOrNot = await showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text(
                      "Are you sure ?",
                    ),
                    content: const Text(
                      "The Image will be deleted",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          "No",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text(
                          "Yes",
                        ),
                      ),
                    ],
                  ),
                );
                if (deleteOrNot) {
                  // delete function call using provider
                  provider.deleteImage(widget.basename);
                  // also pop the page after deletion
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
            IconButton(
              onPressed: _shareImage,
              icon: const Icon(
                Icons.share,
              ),
            ),
          ],
          backgroundColor: Colors.black,
          title: Text(
            widget.basename,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 333),
                  curve: Curves.fastOutSlowIn,
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _visible = !_visible;
                        // shows and unshows appbar when tapped
                      });
                    },
                    child: InteractiveViewer(
                      panEnabled: true,
                      minScale: 0.5,
                      maxScale: 4,
                      child: Image.file(widget.child),
                    ),
                  ),
                ),
              ],
            ),
            /* SafeArea(
              // to restore bars , Navigator.of(context).pop() will  call  the dispose functions but only dispose the safe area
              child: Align(
                alignment: Alignment.topLeft,
                child: MaterialButton(
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
