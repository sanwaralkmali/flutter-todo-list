import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:todo/todo-item.dart';

class DBProvider {
  static const String TABLE_TODO = "Items";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "title";
  static const String COLUMN_isDONE = "isCompleted";

  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'foodDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating food table");

        await database.execute(
          "CREATE TABLE IF NOT EXISTS $TABLE_TODO ("
          "$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$COLUMN_NAME TEXT,"
          "$COLUMN_isDONE BIT NOT NULL,"
          ")",
        );
      },
    );
  }

  Future<List<TodoItem>> getTodo() async {
    final db = await database;

    var todo = await db
        .query(TABLE_TODO, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_isDONE]);

    List<TodoItem> todolist = List<TodoItem>();

    todo.forEach((currentitem) {
      TodoItem currentItem = TodoItem.fromMap(currentitem);

      todolist.add(currentItem);
    });

    return todolist;
  }

  Future<TodoItem> insert(TodoItem todo) async {
    final db = await database;
    await db.insert(TABLE_TODO, todo.toMap());
    return todo;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_TODO,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
