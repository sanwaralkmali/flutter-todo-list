import 'package:flutter/material.dart';
import 'package:todo/todo-item.dart';

import 'build_item.dart';
import 'floating_doalog.dart';
import 'my_app_bar.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  List<TodoItem> items = new List<TodoItem>();
  List<TodoItem> done = new List<TodoItem>();
  List<TodoItem> undone = new List<TodoItem>();

  void refreshItems(items) {
    setState(() {
      this.items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showdialog(context, items, setState, refreshItems);
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      appBar:
          myappBar(context, widget.title, refreshItems, items, done, undone),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: renderBody(),
        ),
      ),
    );
  }

  Widget renderBody() {
    if (items.length > 0) {
      return buildListView();
    } else {
      return emptyList();
    }
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(items[index], index, items, setState, done, undone);
      },
    );
  }

  Widget emptyList() {
    return Center(child: Text('No items'));
  }
}
