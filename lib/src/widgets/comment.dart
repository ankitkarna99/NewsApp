import 'dart:async';
import '../widgets/loading_container.dart';
import 'package:flutter/material.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final int depth;
  final Map<int, Future<ItemModel>> itemsMap;

  Comment({this.itemId, this.itemsMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemsMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final children = <Widget>[];

        final item = snapshot.data;

        item.kids.forEach((kidId) {
          children.add(
            Comment(
              itemId: kidId,
              itemsMap: itemsMap,
              depth: depth + 1,
            ),
          );
        });

        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(
                left: depth * 16.0 + 16.0,
                right: 16,
              ),
              title: Text(parseHTML(item.text)),
              subtitle: item.by == '' ? Text("Deleted") : Text(item.by),
            ),
            Divider(),
            ...children
          ],
        );
      },
    );
  }

  String parseHTML(String inp) {
    return inp
        .replaceAll('&#x27;', "'")
        .replaceAll('&quot;', '"')
        .replaceAll('&#x2F;', '/')
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '')
        .replaceAll('&gt;', '>')
        .replaceAll('&lt', '<>');
  }
}
