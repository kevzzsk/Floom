import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floom/bloc/bloc.dart';
import 'package:floom/model/Item.dart';
import 'package:floom/model/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  final items;
  CartPage({this.items});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartBloc = CartBloc();

  double subTotal = 0.0;

  @override
  Widget build(BuildContext context) {
    _deleteItem(CartItem delItem) {
      cartBloc.dispatch(DeleteItem(delItem));
      Scaffold.of(context)
        ..showSnackBar(SnackBar(
          content: Text("Deleted \"${delItem.item.name}\""),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () => cartBloc.dispatch(AddItem(delItem.item,delItem.qty)),
          ),
        ));
    }

    return StreamBuilder(
      stream: Firestore.instance.collection('shoppingcart').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            // build shopping cart
            List<CartItem> itemList = new List();
            subTotal = 0.0;
            for (var i in snapshot.data.documents) {
              CartItem cartItem = CartItem.fromJSON(i.data);
              cartItem.docID = i.documentID;
              itemList.add(cartItem);
              subTotal += cartItem.item.price * cartItem.qty;
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        Item item = itemList[index].item;
                        return Dismissible(
                          key: Key(itemList[index].docID),
                          background: Container(
                            color: Colors.red,
                          ),
                          onDismissed: (direction) {
                            // USE BLoC to DELETE
                            // No need setstate as stream builder will rebuilt
                            _deleteItem(itemList[index]);
                          },
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/item',
                                  arguments: item);
                            },
                            child: Hero(
                              tag: item.name,
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child: CachedNetworkImage(
                                        placeholder: (context, string) =>
                                            CircularProgressIndicator(),
                                        imageUrl: item.image,
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
                                              item.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "${NumberFormat.simpleCurrency().format(item.price)}",
                                              style: TextStyle(
                                                  color:
                                                      Colors.deepOrangeAccent,
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
                                          onPressed: () {
                                            // dispatch Additem
                                            cartBloc.dispatch(AddItem(item,1));
                                          },
                                        ),
                                        Container(
                                          child: Text(
                                            itemList[index].qty.toString(),
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.arrow_drop_down),
                                          onPressed: () {
                                            // dispatch Additem -1
                                            if(itemList[index].qty>1){
                                              cartBloc.dispatch(AddItem(item,-1));
                                            }
                                            else{
                                              print("Item cannot decrease in qty!");
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                              "${NumberFormat.simpleCurrency().format(subTotal)}",
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
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
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
          } else {
            return Container();
          }
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator(),),
          );
        }
      },
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
