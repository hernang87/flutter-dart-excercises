import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:news/src/resources/news_provider.dart';
import '../models/item_model.dart';



class NewsApiProvider implements NewsSource {
  final String _root = 'https://hacker-news.firebaseio.com/v0';
  Client _client;

  NewsApiProvider() {
    _client = Client();
  }

  NewsApiProvider.fromClient(Client client) {
    _client = client;
  }

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await _client.get('$_root/topstories.json');
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await _client.get('$_root/item/$id.json');
    final _json = json.decode(response.body);

    return ItemModel.fromJson(_json);    
  }
}