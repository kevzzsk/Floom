import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FloomList extends StatefulWidget {
  final data;

  FloomList({this.data});

  @override
  _FloomListState createState() => _FloomListState();
}

class _FloomListState extends State<FloomList> {
  @override
  Widget build(BuildContext context) {
    Widget _cardBuilder(metadata) {
      return InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/item',arguments: metadata);
        },
        child: new Card(
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                    child: CachedNetworkImage(
                  width: 130,
                  placeholder: (context, string) => CircularProgressIndicator(),
                  imageUrl: metadata['imageurl'],
                  fit: BoxFit.cover,
                )),
                new Text(metadata['name'],
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.w300)),
                new Text("\$" + metadata['price'],
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.w300))
              ],
            )),
      );
    }

    return new Container(
      height: 200,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.data['items'].length,
        itemBuilder: (context, index) {
          return _cardBuilder(widget.data['items'][index]);
        },
      ),
    );
  }
}
