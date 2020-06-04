import 'package:flutter/material.dart';

import 'todo-item.dart';

String todoTitle = '';
bool wrongInput = false;

Future showdialog(context, items, setState, refreshItems) {
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
                      print(items);
                      items.insert(0, new TodoItem(title: todoTitle));
                      print(items);
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
