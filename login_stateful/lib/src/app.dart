import 'package:flutter/material.dart';
import 'screens/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log In',
      home: Scaffold(
        body: LoginScreen()
      )
    );
  }
}