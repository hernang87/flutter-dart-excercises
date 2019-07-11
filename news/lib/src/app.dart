import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/screens/news_detail_screen.dart';
import 'screens/news_list_screen.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'News',            
        onGenerateRoute: _routes         
      )
    );
  }

  Route _routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return NewsListScreen();
        }
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          int id = int.parse(settings.name.replaceFirst('/', ''));
          return NewsDetailScreen(itemId: id);
        }
      );
    }
  }
}