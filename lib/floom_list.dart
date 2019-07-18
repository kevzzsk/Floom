import 'package:floom/model/Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class FloomList extends StatefulWidget {
  final data;
  final Function updateTab;

  FloomList({this.data, this.updateTab});

  @override
  _FloomListState createState() => _FloomListState();
}

class _FloomListState extends State<FloomList> {
  @override
  Widget build(BuildContext context) {
    Widget _cardBuilder(metadata) {
      return InkWell(
        onTap: () async {
          // index == null when back button is pressed
          // index == 1 when shopping cart icon is pressed
          final index =
              await Navigator.pushNamed(context, '/item', arguments: metadata);
          widget.updateTab(index);
        },
        child: Hero(
          tag: metadata.name,
          child: Container(
            width: 200,
            child: new Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        height: 139,
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          placeholder: (context, string) =>
                              CircularProgressIndicator(),
                          imageUrl: metadata.image,
                          fit: BoxFit.fitWidth,
                          width: 200,
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 4, 2),
                        child: new Text(metadata.name,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 4, 4),
                      child: new Text(
                          "${NumberFormat.simpleCurrency().format(metadata.price)}",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: Color.fromARGB(255, 250, 82, 32))),
                    )
                  ],
                )),
          ),
        ),
      );
    }

    return new Container(
      height: 210,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.data['items'].length,
        itemBuilder: (context, index) {
          return _cardBuilder(Item.fromJSON(widget.data['items'][index]));
        },
      ),
    );
  }
}
