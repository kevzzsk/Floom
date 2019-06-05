import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class ItemPage extends StatelessWidget {
  final data;
  ItemPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 82, 32)),
        backgroundColor: Colors.white,
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
            Text(data['name']),
            Text(data['price']),
            CachedNetworkImage(
              placeholder: (context, string) => CircularProgressIndicator(),
              imageUrl: data['imageurl'],
              fit: BoxFit.cover,
            ),
            Text('Description'),
            Text('Loren Ipsum shit....')
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: InkWell(
          onTap: () {
            // Navigate to cart Checkout
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text('Purchase',style: TextStyle(color: Theme.of(context).accentColor),), Icon(Icons.add_shopping_cart,color: Theme.of(context).accentColor,)],
            ),
          ),
        ),
      ),
    );
  }
}
