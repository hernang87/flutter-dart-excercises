import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final int itemId;

  NewsDetailScreen({ this.itemId });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Story Detail')),
      body: Text('${itemId}')
    );
  }
}