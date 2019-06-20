import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => CartInitial();

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
      // LOGIC HERE
      if (event is AddItem){
        Firestore.instance.runTransaction((transaction)async{
          await transaction.set(Firestore.instance.collection('shoppingcart').document(), event.item.toJson());
        });
      }
      if(event is DeleteItem){
        Firestore.instance.runTransaction((transaction)async{
          await transaction.delete(Firestore.instance.collection('shoppingcart').document(event.delItem.docID));
        });
      }
  }
}
