import 'package:flutter/material.dart';

import 'history-page.dart';

AppBar myappBar(context, String title, refreshItems, items, done, undone) {
  return AppBar(
    actions: [
      FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          refreshItems(items);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SecondRoute(refreshItems, items, done, undone),
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
      title,
      style: TextStyle(
          fontFamily: 'Righteous',
          fontWeight: FontWeight.w100,
          fontSize: 42.0,
          color: Colors.red.shade100,
          letterSpacing: 3.0),
    ),
  );
}
