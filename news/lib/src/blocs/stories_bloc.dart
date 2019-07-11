import 'package:news/src/models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:news/src/resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();
    
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream
      .transform(_itemsTransformer())
      .pipe(_itemsOutput);
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

  Future<void> clearCache() {
    return _repository.clearCaches();
  }

  void dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}