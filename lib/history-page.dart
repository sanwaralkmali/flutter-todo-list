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

  changeItemCompleteness(item) {}
  goToEditItemView(item) {}

  void refreshItems(done, undone) {
    setState(() {
      getal();
    });
  }

  Future<void> _showMyDialog(dbHelper) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('AlertDialog Title'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Clear History'),
                      Text('Would you like to approve of this message?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Approve'),
                    onPressed: () async {
                      await dbHelper.deleteallHistory();

                      refreshItems(done, undone);
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
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
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey.shade800,
            actions: [
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () async {
                  setState(() {
                    _showMyDialog(widget.dbHelper);
                  });
                },
                child: Icon(
                  Icons.restore_from_trash,
                  color: Colors.red.shade100,
                  size: 36.0,
                ),
              ),
            ],
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
                      onTap: () => changeItemCompleteness(done[index]),
                      onLongPress: () => goToEditItemView(done[index]),
                      title: Text(
                        done[index].title,
                        key: Key('item-$index'),
                        style: TextStyle(
                            color: done[index].completed
                                ? Colors.grey
                                : Colors.black,
                            decoration: done[index].completed
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      trailing: Icon(
                        Icons.check,
                      ),
                    ),
                  );
                },
              ),
              ListView.builder(
                itemCount: undone.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        const Radius.circular(7.0),
                      ),
                      shape: BoxShape.rectangle,
                      border: Border.all(),
                      color: Colors.red.shade200,
                    ),
                    child: ListTile(
                      onTap: () => changeItemCompleteness(undone[index]),
                      onLongPress: () => goToEditItemView(undone[index]),
                      title: Text(
                        undone[index].title,
                        key: Key('item-$index'),
                        style: TextStyle(
                            color: undone[index].completed
                                ? Colors.grey
                                : Colors.black,
                            decoration: undone[index].completed
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      trailing: Icon(
                        Icons.close,
                      ),
                    ),
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
