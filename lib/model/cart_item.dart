

import 'package:floom/model/Item.dart';

class CartItem {
  final Item item;
  final int qty;
  String docID;

  CartItem({this.item,this.qty,this.docID});
  
  factory CartItem.fromJSON(Map<dynamic,dynamic> parsedJson){
    return CartItem(
      item: Item.fromJSON(parsedJson['item']),
      qty: parsedJson['qty']
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'item': item.toJson(),
      'qty': qty,
      };
}