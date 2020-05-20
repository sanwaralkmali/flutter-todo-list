import 'package:flutter/material.dart';
import 'history-page.dart';
import 'todo-item.dart';

void main() => runApp(MyApp());

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
      home: MyHomePage(
        title: 'TODO',
      ),
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
/*
  void _addNewToDoItem() {
    setState(() {
      widget.list.add(
        Dissmis(setState, TodoItem(newTodo)),
      );
      widget.list.add(
        Text(indexM.toString()),
      );

      wrongInput = false;
    });
  }
*/
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
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container();
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
                            // newTodo = text;
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
                          /*
                          if (newTodo == '') {
                            setState(() {
                              wrongInput = true;
                            });
                          } else {
                            _addNewToDoItem();
                            newTodo = '';
                            Navigator.of(context).pop();
                          }
                        */
                        },
                        child: Text('Okay'),
                      ),
                      FlatButton(
                        onPressed: () {
                          /*
                          wrongInput = false;
                          newTodo = '';
                          Navigator.of(context).pop();
                       */
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

// TODO : implement the onDismissed hundler and remove the dismissable widegt from your list
// TODO : Fix the History Page
// TODO : Start SQLight to store your app info

/****************************** *********************************/

/*
Widget Dissmis(setState, todoItem) {
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
          value: boxStatus,
          onChanged: (bool changeState) {
            setState(() {
              boxStatus = !boxStatus;
              print(boxStatus);
            });
          },
        ),
      ),
    ),
    onDismissed: (direction) => print(''),
    background: Container(
      color: Colors.green,
    ),
  );
}
*/
