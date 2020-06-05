import 'package:flutter/material.dart';
import 'package:todo/todo-item.dart';

class SecondRoute extends StatefulWidget {
  final Function refreshItems;
  final dbHelper;
  SecondRoute(this.dbHelper, this.refreshItems);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  List<TodoItem> done;
  List<TodoItem> undone;

  void getal() async {
    done = new List<TodoItem>();
    undone = new List<TodoItem>();

    /* DELETE ALL HISTORY RECORDS*/
    // int a = await widget.dbHelper.deleteall();
    // print(a);

    final allDone = await widget.dbHelper.queryAllRowsHistory(1);
    final allUndon = await widget.dbHelper.queryAllRowsHistory(0);
    allDONE(allDone);
    allUNDONE(allUndon);
  }

  void allDONE(allDone) {
    allDone.forEach((row) {
      int id;
      String itemtitle;
      row.forEach((key, value) {
        if (key == 'title') itemtitle = value;
        if (key == '_id') id = value;
      });

      setState(() {
        this.done.insert(0, new TodoItem(title: itemtitle, id: id));
      });
    });
  }

  void allUNDONE(allUndone) {
    allUndone.forEach((row) {
      int id;
      String itemtitle;
      row.forEach((key, value) {
        if (key == 'title') itemtitle = value;
        if (key == '_id') id = value;
      });

      setState(() {
        this.undone.insert(0, new TodoItem(title: itemtitle, id: id));
      });
    });
  }

  @override
  void initState() {
    getal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: FlatButton(
              child: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                //refreshItems(items);
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(child: Text('Done')),
                Tab(child: Text('Undone')),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListView.builder(
                itemCount: done.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Text(done[index].title),
                  );
                },
              ),
              ListView.builder(
                itemCount: undone.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Text(undone[index].title),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
