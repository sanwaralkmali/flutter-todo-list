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
      home: MyHomePage(title: 'TODO'),
      debugShowCheckedModeBanner: false,
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
        ToDoDissmissable(
          TodoItem(newTodo),
        ),
      );
      wrongInput = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondRoute(),
                ),
              );
            },
            child: Icon(
              Icons.history,
              color: Colors.red.shade100,
              size: 36.0,
            ),
          ),
        ],
        backgroundColor: Colors.blueGrey.shade800,
        title: Text(
          widget.title,
          style: TextStyle(
              fontFamily: 'Righteous',
              fontWeight: FontWeight.w100,
              fontSize: 42.0,
              color: Colors.red.shade100,
              letterSpacing: 3.0),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return _list[index];
            },
          ),
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

// TODO : Add a menu to Your AppBar
// TODO : Fix the History Page
// TODO : Start SQLight to store your app info
