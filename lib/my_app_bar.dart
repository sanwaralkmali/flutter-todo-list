import 'package:flutter/material.dart';

import 'history-page.dart';

AppBar myappBar(dbHelper, context, String title, refreshItems) {
  return AppBar(
    actions: [
      FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondRoute(dbHelper, refreshItems),
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
