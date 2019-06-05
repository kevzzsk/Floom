import 'package:flutter/material.dart';


class CartPage extends StatelessWidget {
  final items;
  CartPage({this.items});

  add_item_to_cart(){
    
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 82, 32)),
        backgroundColor: Colors.white,
        title: Text(
          "Shopping Cart",
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 250, 82, 32)),
        ),
      ),
      body: new Container(
        child: ,
      ),
    );
  }
}