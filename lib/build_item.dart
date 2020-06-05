import 'package:flutter/material.dart';
import 'todo-item.dart';

Widget buildItem(TodoItem item, index, items, setState, done, undone) {
  return Dismissible(
    key: Key('${item.hashCode}'),
    background: Container(color: Colors.red[700]),
    onDismissed: (direction) =>
        _removeItemFromList(item, items, setState, done, undone),
    direction: DismissDirection.startToEnd,
    child: buildListTile(item, index, setState),
  );
}

Widget buildListTile(item, index, setState) {
  return Container(
    margin: EdgeInsets.all(2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        const Radius.circular(7.0),
      ),
      shape: BoxShape.rectangle,
      border: Border.all(),
      color: Colors.lightGreen.shade100,
    ),
    child: ListTile(
      onTap: () => changeItemCompleteness(item, setState),
      onLongPress: () => goToEditItemView(item),
      title: Text(
        item.title,
        key: Key('item-$index'),
        style: TextStyle(
            color: item.completed ? Colors.grey : Colors.black,
            decoration: item.completed ? TextDecoration.lineThrough : null),
      ),
      trailing: Icon(
        item.completed ? Icons.check_box : Icons.check_box_outline_blank,
        key: Key('completed-icon-$index'),
      ),
    ),
  );
}

void goToEditItemView(item) {
  print(item.title);
}

void changeItemCompleteness(TodoItem item, setState) {
  setState(() {
    item.completed = !item.completed;
  });
}

void _removeItemFromList(item, items, setState, done, undone) {
  setState(() {
    if (item.completed)
      done.insert(0, new TodoItem(title: item.title));
    else
      undone.insert(0, new TodoItem(title: item.title));

    items.remove(item);
  });
}
