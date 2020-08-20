import "package:flutter/material.dart";
import "comments_bloc.dart";
export "comments_bloc.dart";

class CommentsProvider extends InheritedWidget {
  final bloc = CommentsBloc();

  CommentsProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static CommentsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CommentsProvider>())
        .bloc;
  }
}
