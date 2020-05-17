import 'package:flutter/material.dart';
//import 'package:todo_list/list-generator.dart';

Dismissible todoDismissable(todoItem) {
  return Dismissible(
    key: Key(todoItem.hashCode.toString()),
    child: ListTile(
      leading: Text('data'),
      title: Text(todoItem.getTitle()),
    ),
    onDismissed: (direction) => onDismissedAction(direction),
  );
}

void onDismissedAction(direction) {
  if (direction == DismissDirection.endToStart)
    print('right');
  else if (direction == DismissDirection.startToEnd) print('left');
}
