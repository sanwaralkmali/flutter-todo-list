import 'package:flutter/material.dart';
import 'package:todo/todo-item.dart';

class SecondRoute extends StatelessWidget {
  final Function refreshItems;
  final List<TodoItem> items;
  final List<TodoItem> done;
  final List<TodoItem> undone;
  SecondRoute(this.refreshItems, this.items, this.done, this.undone);
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
