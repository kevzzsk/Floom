import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floom/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemPage extends StatelessWidget {
  final data;
  ItemPage({this.data});

  @override
  Widget build(BuildContext context) {
    _addItemToCart(item) {
      final cartBloc = CartBloc();
      cartBloc.dispatch(AddItem(item));
    }

    Widget _buildItemCounter(){
      // use Stream builder to listen to item count changes
      return StreamBuilder(
        stream: Firestore.instance.collection('shoppingcart').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if ( snapshot.hasData){
            if(snapshot.data!= null){
              int counter = snapshot.data.documents.length;
              return counter !=0? Positioned(
                right: 8,
                top: 8,
                child: new Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  constraints: BoxConstraints(minHeight: 14,minWidth: 14),
                  child: Text('$counter',style: TextStyle(color: Colors.white,fontSize: 10),textAlign: TextAlign.center,),
                ),
              ):Container();
            }
          }
          return Container();
        },
      );
    }

    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 82, 32)),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                onPressed: (){
                  // TODO:
                  Navigator.pop(context,1);
                },
                icon: Icon(Icons.shopping_cart),
              ),
              _buildItemCounter()
            ],
          ),
        ],
        title: Text(
          "Floom",
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 250, 82, 32)),
        ),
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              height: 400,
              child: CachedNetworkImage(
                placeholder: (context, string) => CircularProgressIndicator(),
                imageUrl: data.imageurl,
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.name,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Text("\$" + data.price.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Loren Ipsum blahlbhlvlahblahvlagblahlbahlbah....')
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(),
        child: InkWell(
          onTap: () {
            _addItemToCart(data);
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Purchase',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                Icon(
                  Icons.add_shopping_cart,
                  color: Theme.of(context).accentColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
