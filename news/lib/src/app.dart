import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'screens/news_list_screen.dart';

class App extends StatelessWidget {
  build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'News',    
        home: NewsListScreen(),
      )
    );
  }
}