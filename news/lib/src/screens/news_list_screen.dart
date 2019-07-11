import 'package:flutter/material.dart';
import 'package:news/src/widgets/refresh.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';


class NewsListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    
    bloc.fetchTopIds();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: _buildList(context, bloc),
    );
  }

  Widget _buildList(BuildContext context, StoriesBloc bloc) {    
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator()
          );
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data[index]);
                              
              return NewsListTile(              
                itemId: snapshot.data[index]
              );
            },
          )
        );
      },
    );
  }
}