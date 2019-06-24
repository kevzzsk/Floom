import 'package:floom/model/Item.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CartEvent {}


class AddItem extends CartEvent{
  final Item item;

  AddItem(this.item);
}

class GetItems extends CartEvent{}

class DeleteItem extends CartEvent{
  final Item delItem;

  DeleteItem(this.delItem);
}
