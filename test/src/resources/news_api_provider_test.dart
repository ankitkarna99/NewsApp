import 'package:NewsApp/src/models/item_model.dart';
import 'package:NewsApp/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('fetchTopIds returns a list of id', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((Request request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('fetchTopIds returns a item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((Request request) async {
      return Response(
          json.encode({
            "id": 8863,
          }),
          200);
    });

    final item = await newsApi.fetchItem(8863);

    expect(item.id, 8863);
  });
}
