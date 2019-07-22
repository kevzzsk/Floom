
import 'package:floom/model/Item.dart';
import 'package:floom/model/cart_item.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CartEvent {}


class AddItem extends CartEvent{
  final Item item;
  final int qty;

  AddItem(this.item,this.qty);
}

class GetItems extends CartEvent{}

class DeleteItem extends CartEvent{
  final CartItem delItem;

  DeleteItem(this.delItem);
}
