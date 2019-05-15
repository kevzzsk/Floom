import 'package:floom/floom_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final catCount = 10;

  @override
  Widget build(BuildContext context) {
    final itemList = new ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Card(
            child: new Column(
              children: <Widget>[
                Text("Category"),
                FloomList()
              ],
            ),
          ),
        );
      },
    );
    return itemList;
  }
}
