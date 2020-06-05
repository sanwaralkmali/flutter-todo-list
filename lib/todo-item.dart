import 'Database/datab.dart';

class TodoItem {
  int id;
  String title;
  bool completed;

  TodoItem({
    this.id,
    this.title,
    this.completed = false,
  });

  updateTitle(title) {
    this.title = title;
  }

  updateId(id) {
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseHelper.COLUMN_TITLE: title,
      DatabaseHelper.COLUMN_isDONE: completed ? 1 : 0,
    };
    if (id != null) {
      map[DatabaseHelper.COLUMN_ID] = id;
    }

    return map;
  }

  TodoItem.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseHelper.COLUMN_ID];
    title = map[DatabaseHelper.COLUMN_TITLE];
    completed = map[DatabaseHelper.COLUMN_isDONE] == false;
  }
}
