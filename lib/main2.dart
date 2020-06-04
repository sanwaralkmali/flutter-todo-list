import 'package:flutter/material.dart';
import 'package:todo/todo-brain.dart';
import 'history-page.dart';
import 'todo-item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

TodoBrain todoBrain = new TodoBrain();
int itemID = 0;
String todoTitle = '';
int todoSize = todoBrain.todo.length;
bool wrongInput = false;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    void setSizeofList() => todoSize = todoBrain.todo.length;

    Future showme() {
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
                    onPressed: () {
                      setState(() {
                        if (todoTitle == '') {
                          wrongInput = true;
                        } else {
                          todoBrain.addItem(new TodoItem(todoTitle, itemID));
                          wrongInput = false;
                          todoTitle = '';
                          itemID++;
                          todoSize = todoBrain.todo.length;
                          setSizeofList();
                          Navigator.of(context).pop();
                        }
                      });
                    },
                    child: Text('Okay'),
                  ),
                  FlatButton(
                    onPressed: () {
                      todoSize = todoBrain.getSize();

                      setState(() {
                        todoSize = todoBrain.getSize();

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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(
            () {
              showme();
            },
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
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
            itemCount: todoSize,
            itemBuilder: (context, index) {
              /*****************   Dismissable  *****************/

              return Dismissible(
                key: Key(this.hashCode.toString()),
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
                      todoBrain.getItem(index).getTitle(),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Checkbox(
                      value: true,
                      onChanged: (bool changeState) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                onDismissed: (direction) => print(''),
                background: Container(
                  color: Colors.green,
                ),
              );
            },
          ),
        ),
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
