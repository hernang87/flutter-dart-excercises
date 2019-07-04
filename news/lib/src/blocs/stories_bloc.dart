import 'package:news/src/models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:news/src/resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();
  
  Observable<Map<int, Future<ItemModel>>> items;
  Observable<List<int>> get topIds => _topIds.stream;

  Function(int) get fetchItem => _items.sink.add;

  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  } 

  _itemsTransformer() =>
    ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{}
    );
  

  void fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  void dispose() {
    _topIds.close();
    _items.close();
  }
}