import 'blocs/comments_provider.dart';
import 'blocs/stories_provider.dart';
import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: "News App",
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) {
            final storiesBloc = StoriesProvider.of(context);
            storiesBloc.fetchTopIds();

            return NewsList();
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            final int itemId = int.parse(settings.name.split("/")[1]);
            final commentsBloc = CommentsProvider.of(context);
            commentsBloc.fetchItemWithComments(itemId);
            return NewsDetail(id: itemId);
          },
        );
    }
  }
}
