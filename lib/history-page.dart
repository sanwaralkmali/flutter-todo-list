import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
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
              onPressed: () => Navigator.of(context).pop(),
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
              Text(
                'These are the compeleted tasks ! ',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              Text(
                'These are the uncompeleted tasks ! ',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
