import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    }
    return _db;
  }

  intialDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'nojaid.db');
    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);

    return db;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''CREATE TABLE tasks(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    subTitle TEXT NOT NULL,
    dateTime TEXT NOT NULL,
    date TEXT NOT NULL,
    isDone INTEGER NOT NULL,
    priority TEXT NOT NULL,
    repet INTEGER NOT NULL
    ) ''');

    await batch.commit();
  }

  readData(String sql) async {
    Database? sqlDb = await db;
    List<Map> response = await sqlDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? sqlDb = await db;
    int response = await sqlDb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? sqlDb = await db;
    int response = await sqlDb!.rawUpdate(sql);
    return response;
  }

  deleteApp() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'nojaid.db');
    GetStorage().erase();
    deleteDatabase(path);
    SystemNavigator.pop();
  }

  deleteData(String sql) async {
    Database? sqlDb = await db;
    int response = await sqlDb!.rawDelete(sql);
    return response;
  }
}
