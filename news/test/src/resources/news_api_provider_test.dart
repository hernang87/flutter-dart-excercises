import 'package:http/http.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/testing.dart';

void main() {
  test('fetchTopIds returns a list of ids', () async  {
    final mock = MockClient((_) async => Response(json.encode([1, 2, 3, 4]), 200));
    final newsApi = NewsApiProvider.fromClient(mock);
    final ids = await newsApi.fetchTopIds();

    expect(ids, [1,2,3,4]);
  });

  test('fetchItem returns an ItemModel', () async {
    final mock = MockClient((_) async {
      final obj = { 'id': 123 };
      return Response(json.encode(obj), 200);
    });

    final newsApi = NewsApiProvider.fromClient(mock);
    
    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);  
  });
}