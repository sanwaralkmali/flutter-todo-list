import 'package:flutter/material.dart';
import 'package:todo/todo-item.dart';

import 'Database/datab.dart';
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
  List<TodoItem> items;
  List<TodoItem> done = new List<TodoItem>();
  List<TodoItem> undone = new List<TodoItem>();
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    getal();
    super.initState();
  }

  void getal() async {
    items = new List<TodoItem>();
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      print(row.toString());
      int id;
      String itemtitle;
      row.forEach((key, value) {
        if (key == 'title') itemtitle = value;
        if (key == '_id') id = value;
      });

      setState(() {
        items.insert(0, new TodoItem(title: itemtitle, id: id));
      });

      print(items.length);
    });
  }

  void refreshItems(items) {
    setState(() {
      getal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showdialog(dbHelper, context, items, setState, refreshItems);
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      appBar: myappBar(dbHelper, context, widget.title, refreshItems),
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
        return buildItem(
            dbHelper, items[index], index, items, setState, done, undone);
      },
    );
  }

  Widget emptyList() {
    return Center(child: Text('No items'));
  }
}
