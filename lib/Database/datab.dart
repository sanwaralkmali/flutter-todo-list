import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "TodoItems.db";
  static final _databaseVersion = 1;

  static const String TABLE_TODO = "Items";
  static const String COLUMN_ID = "_id";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_isDONE = "isCompleted";

  static const String HISTORY_TABLE = "History";
  static const String HISTORY_ID = "_id";
  static const String HISTORY_TITLE = "title";
  static const String HISTORY_CHECK = "isCompleted";

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $TABLE_TODO (
            $COLUMN_ID INTEGER PRIMARY KEY ,
            $COLUMN_TITLE TEXT,
            $COLUMN_isDONE BIT NOT NULL
            )
          ''');

    await db.execute('''
          CREATE TABLE $HISTORY_TABLE (
            $HISTORY_ID INTEGER PRIMARY KEY ,
            $HISTORY_TITLE TEXT,
            $HISTORY_CHECK BIT NOT NULL
            )
          ''');
    print("FINALLY SUCCEFUL");
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(TABLE_TODO, row);
  }

  Future<int> insertHistory(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(HISTORY_TABLE, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(TABLE_TODO);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsHistory(isCompleted) async {
    int status = isCompleted;
    Database db = await instance.database;
    return await db.rawQuery('''SELECT * FROM $HISTORY_TABLE WHERE 
    $HISTORY_CHECK = $status''');
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $TABLE_TODO'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[COLUMN_ID];
    return await db
        .update(TABLE_TODO, row, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(TABLE_TODO, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }

  Future<int> deleteall() async {
    Database db = await instance.database;
    return await db.delete(TABLE_TODO);
  }

  Future<int> deleteallHistory() async {
    Database db = await instance.database;
    return await db.delete(HISTORY_TABLE);
  }
}
