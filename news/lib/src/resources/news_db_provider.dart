import 'dart:async';
import 'dart:io';
import 'package:news/src/resources/news_cache.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item_model.dart';
import 'news_source.dart';

class NewsDbProvider implements NewsSource, NewsCache {  
  Database _db;

  NewsDbProvider() {
    this.init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items2.db');

    _db = await openDatabase(
      path,
      version: 1,      
      onCreate: (Database newDb, int version) {
        newDb.execute(
          '''
          CREATE TABLE items (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            text TEXT,
            parent int,
            kids BLOB,
            dead INTEGER, 
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title INTEGER,
            descendants INTEGER,
            time INTEGER
          )
          '''
        );
      }
    );
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await _db.query(
      'items', 
      columns: null,
      where: 'id = ?',
      whereArgs: [id]
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    return _db.insert(
      'items', 
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  Future<int> clear() {
    return _db.delete('items');
  }

  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }
}

final newsDbProvider = NewsDbProvider();
