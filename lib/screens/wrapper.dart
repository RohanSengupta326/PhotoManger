import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreenPage extends StatefulWidget {
  FullScreenPage({
    required this.child,
    required this.basename,
  });

  final Image child;
  final String basename;

  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  @override
  void initState() {
    var brightness = Brightness.dark;
    var color = Colors.black12;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    // to hide bars from top and bottom
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.basename,
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
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.5,
                    maxScale: 4,
                    child: widget.child,
                  ),
                ),
              ],
            ),
            SafeArea(
              // to restore bars , Navigator.of(context).pop() will  call  the dispose functions but only dispose the safe area
              child: Align(
                alignment: Alignment.topLeft,
                child: MaterialButton(
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
