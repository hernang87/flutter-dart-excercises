import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;

  Comment({ this.itemId, this.itemMap });

  @override
  Widget build(BuildContext context) {    
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if(!snapshot.hasData) {
          return Text('Loading comments...');
        }

        final item = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: item.text == '' ? Text('Deleted') : Text(item.text),
            subtitle: item.by == '' ? Text('Deleted') : Text(item.by),
          ),
          Divider()
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(Comment(
            itemId: itemId,
            itemMap: itemMap,
          ));
        });

        return Column(
          children: children,
        );
      },
    );
  }
}