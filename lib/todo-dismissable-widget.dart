import 'package:flutter/material.dart';
import 'package:todo/todo-item.dart';

//import 'package:todo_list/list-generator.dart';
bool checkBoxState = false;

class ToDoDissmissable extends StatefulWidget {
  final TodoItem todoItem;
  ToDoDissmissable(this.todoItem, {Key key}) : super(key: key);

  @override
  _ToDoDissmissableState createState() => _ToDoDissmissableState(todoItem);
}

class _ToDoDissmissableState extends State<ToDoDissmissable> {
  TodoItem todoItem;
  _ToDoDissmissableState(this.todoItem);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todoItem.hashCode.toString()),
      child: Container(
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
          isThreeLine: true,
          subtitle: Text('Detailes'),
          title: Text(
            todoItem.getTitle(),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Checkbox(
            value: checkBoxState,
            onChanged: (bool changeState) {
              setState(() {
                checkBoxState = !checkBoxState;
              });
            },
          ),
        ),
      ),
      onDismissed: (direction) => print(todoItem.hashCode.toString()),
      background: Container(
        color: Colors.green,
      ),
    );
  }
}

void onDismissedAction(direction) {
  if (direction == DismissDirection.endToStart)
    print('right');
  else if (direction == DismissDirection.startToEnd) print('left');
}
