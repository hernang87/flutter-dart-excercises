import 'package:flutter/material.dart';
import 'screens/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat in a box',
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
    );
  }
}