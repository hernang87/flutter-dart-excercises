import 'dart:async';
import 'package:news/src/models/item_model.dart';

abstract class NewsCache {
  Future<int> addItem(ItemModel item);
}