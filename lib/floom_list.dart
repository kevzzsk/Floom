import 'package:flutter/material.dart';

class FloomList extends StatefulWidget {
  @override
  _FloomListState createState() => _FloomListState();
}

class _FloomListState extends State<FloomList> {
  final count = 10;
  @override
  Widget build(BuildContext context) {

    final horizontalList = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: count,
      itemBuilder: (BuildContext context, int count) {
        return new Text("hii");
      },
    );

    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,count){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("asdladj"),
          );
        },
      ),
    );
  }
}
