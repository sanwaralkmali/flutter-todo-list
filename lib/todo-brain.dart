import 'todo-item.dart';

class TodoBrain {
  List<TodoItem> todo = [];

  void addItem(TodoItem newItem) {
    todo.add(newItem);
  }

  void removeItem(int id) {
    TodoItem teRemove;
    for (int i = 0; i < todo.length; i++) {
      if (todo[i].id == id) {
        teRemove = todo[i];
        todo.remove(teRemove);
      }
    }
  }

  int getIndex(int id) {
    TodoItem teRemove;
    for (int i = 0; i < todo.length; i++) {
      if (todo[i].id == id) {
        teRemove = todo[i];
        todo.indexOf(teRemove);
      }
    }
  }
}
