import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floom/bloc/bloc.dart';
import 'package:floom/model/Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class CartPage extends StatefulWidget {
  final items;
  CartPage({this.items});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartBloc = CartBloc();

  

  @override
  Widget build(BuildContext context) {

    _deleteItem(Item delItem) {
    cartBloc.dispatch(DeleteItem(delItem));
    Scaffold.of(context)
      ..showSnackBar(SnackBar(
        content: Text("Deleted \"${delItem.name}\""),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () => cartBloc.dispatch(AddItem(delItem)),
        ),
      ));
  }
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
            stream: Firestore.instance.collection('shoppingcart').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  // build shopping cart
                  List<Item> itemList = new List();
                  for (var i in snapshot.data.documents) {
                    Item item = Item.fromJSON(i.data);
                    item.docID = i.documentID;
                    itemList.add(item);
                  }
                  return ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(itemList[index].name),
                          background: Container(
                            color: Colors.red,
                          ),
                          onDismissed: (direction) {
                            // USE BLoC to DELETE
                            // No need setstate as stream builder will rebuilt
                            _deleteItem(itemList[index]);
                          },
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: CachedNetworkImage(
                                    placeholder: (context, string) =>
                                        CircularProgressIndicator(),
                                    imageUrl: itemList[index].imageurl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          itemList[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "\$" +
                                              itemList[index].price.toString(),
                                          style: TextStyle(
                                              color: Colors.deepOrangeAccent,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.arrow_drop_up),
                                      onPressed: () {},
                                    ),
                                    Container(
                                      child: Text(
                                        "1",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.arrow_drop_down),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              } else {
                return Container(
                  child: Text("Shopping cart is empty!"),
                );
              }
            },
          ),
        ),
        Container(
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('SubTotal'),
                    Text(
                      "\$199",
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.deepOrange,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Text(
                        "Check Out",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
