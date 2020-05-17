import 'package:flutter/material.dart';
import 'history-page.dart';
import 'todo-item.dart';
import 'todo-dismissable-widget.dart';

void main() {
  runApp(MyApp());
}

List<Widget> _list = [];

String newTodo = '';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Todo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool wrongInput = false;

  void _addNewToDoItem() {
    setState(() {
      _list.add(
        todoDismissable(
          TodoItem(newTodo),
        ),
      );
      wrongInput = false;
    });
  }

  void _showWrongMessage() {
    setState(() {
      wrongInput = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade200,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade700,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return _list[index];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
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
                            newTodo = text;
                          },
                        ),
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
                        onPressed: () {
                          if (newTodo == '') {
                            setState(() {
                              wrongInput = true;
                            });
                          } else if (newTodo == 'history') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SecondRoute(),
                              ),
                            );
                          } else {
                            _addNewToDoItem();
                            newTodo = '';
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Okay'),
                      ),
                      FlatButton(
                        onPressed: () {
                          wrongInput = false;
                          newTodo = '';
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
