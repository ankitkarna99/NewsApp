import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items2.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE items
            (
              id INTEGER PRIMARY KEY,
              deleted INTEGER,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              dead INTEGER,
              parent INTEGER,
              kids BLOB,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);
      },
    );
  }

  NewsDbProvider() {
    init();
  }

  Future<List<int>> fetchTopIds() {
    return null;
  }

  Future<int> clear() {
    return db.delete("items");
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      "items",
      item.toMapForDb(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}

final newsDbProvider = NewsDbProvider();
