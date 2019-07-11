import 'package:flutter/cupertino.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc extends InheritedWidget {
  final _repository = Repository();

  final _items = BehaviorSubject<ItemModel>();
  final _topIds = BehaviorSubject<List<int>>();

  Observable<List<int>> get topIds => _topIds.stream;  
  Function(List<int>) get _addTopIds => _topIds.sink.add;

  void fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _addTopIds(ids);
  }

  @override
  bool updateShouldNotify(_) => true;

  void dispose() {
    _items.close();
    _topIds.close();
  }
}

final bloc = NewsBloc();