import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloomList extends StatefulWidget {
  @override
  _FloomListState createState() => _FloomListState();
}

class _FloomListState extends State<FloomList> {
  final count = 10;
  @override
  Widget build(BuildContext context) {
    final itemList = new ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, count) {
        return Container(
          constraints: BoxConstraints(maxHeight: 100),
          height: 100,
          child: new Row(
            children: <Widget>[
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Image.asset("assets/images/flower1.jpg"),
                    new Text("Name"),
                    new Text("Price")
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
    return new SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Image.asset("assets/images/flower1.jpg"),
                new Text("Name"),
                new Text("Price")
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Image.asset("assets/images/flower1.jpg"),
                new Text("Name"),
                new Text("Price")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
