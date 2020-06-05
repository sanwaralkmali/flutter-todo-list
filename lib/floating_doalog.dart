import 'package:flutter/material.dart';

import 'Database/datab.dart';
import 'todo-item.dart';

String todoTitle = '';
bool wrongInput = false;

void _insert(dbHelper, title, item) async {
  // row to insert
  Map<String, dynamic> row = {
    DatabaseHelper.COLUMN_TITLE: title,
    DatabaseHelper.COLUMN_isDONE: 0,
  };
  final id = await dbHelper.insert(row);
  item.updateId(id);
}

Future showdialog(dbHelper, context, items, setState, refreshItems) {
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: new Text('Add new Todo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (text) {
                    todoTitle = text;
                  },
                ),
                SizedBox(height: 10.0),
                Visibility(
                  child: Text(
                    'Enter a title ',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  visible: wrongInput,
                ),
              ],
            ),
            actions: [
              FlatButton(
                onPressed: () async {
                  setState(() {
                    if (todoTitle == '') {
                      wrongInput = true;
                    } else {
                      TodoItem item = new TodoItem(title: todoTitle);
                      items.insert(0, item);
                      _insert(dbHelper, todoTitle, item);
                      wrongInput = false;
                      todoTitle = '';
                      refreshItems(items);
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    }
                  });
                },
                child: Text('Okay'),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    wrongInput = false;
                    todoTitle = '';
                    Navigator.of(context).pop();
                  });
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    },
  );
}
