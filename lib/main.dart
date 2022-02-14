import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          secondary: Colors.yellow,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
