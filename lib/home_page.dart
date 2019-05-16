import 'dart:async';

import 'package:floom/floom_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  Function callback;
  HomePage({this.callback});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;

  // Future _futureCallback() async {
  //   widget.callback(data['category']);
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(widget),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            // return item list to parent
            data = snapshot.data;

            return new ListView.builder(
              itemCount: data['category'].length,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  color: Colors.white,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          data['category'][index]['name'],
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      FloomList(data: data['category'][index]),
                      Divider()
                    ],
                  ),
                );
              },
            );
          }
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        } else {
          return new CircularProgressIndicator();
        }
      },
    );
  }
}

Future loadData(widget) async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  final jsonResponse = json.decode(jsonString);
  widget.callback(jsonResponse);
  return jsonResponse;
}
