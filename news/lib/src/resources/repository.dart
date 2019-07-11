import 'dart:async';
import 'package:news/src/resources/news_cache.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';
import 'package:news/src/models/item_model.dart';

import 'news_source.dart';

class Repository implements NewsSource {
  final List<NewsSource> sources = <NewsSource> [
    newsDbProvider,
    NewsApiProvider()
  ];
  
  final List<NewsCache> caches = <NewsCache>[
    newsDbProvider
  ];

  Future<List<int>> fetchTopIds() async {
    for(NewsSource source in sources) {
      var topIds = await source.fetchTopIds();
      
      if (topIds != null) return topIds;
    }

    return List<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;

    for(source in sources) {
      item = await source.fetchItem(id);

      if (item != null) break;
    }

    for(NewsCache cache in caches) {
      if (cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }

  Future<void> clearCaches() async {
    for(NewsCache cache in caches) {
      await cache.clear();
    }
  }
}