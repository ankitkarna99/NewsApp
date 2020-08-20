import '../models/item_model.dart';
import '../widgets/comment.dart';

import '../blocs/comments_provider.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final int id;

  NewsDetail({this.id});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading...");
        }

        final itemFuture = snapshot.data[id];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text("Future Loading");
            }

            return buildList(snapshot.data, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(Map<int, Future<ItemModel>> itemsMap, ItemModel item) {
    final commentsList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemsMap: itemsMap,
        depth: 0,
      );
    }).toList();

    return ListView(
      children: [buildTitle(item.title), ...commentsList],
    );
  }

  Widget buildTitle(String title) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
