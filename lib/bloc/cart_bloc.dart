import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:floom/model/cart_item.dart';
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
    List<DocumentSnapshot> docsnap;
    if (event is AddItem) {
      Firestore.instance
          .collection('shoppingcart')
          .where('item.itemid', isEqualTo: event.item.itemID)
          .getDocuments()
          .then((value) {
        docsnap = value.documents;
        Firestore.instance.runTransaction((transaction) async {
          // check if item already exists - if yes, increment qty, else add new doc
          if (docsnap != null) {
            if (docsnap.isEmpty) {
              await transaction.set(
                  Firestore.instance.collection('shoppingcart').document(),
                  CartItem(item: event.item, qty: event.qty).toJson());
            } else {
              await transaction.update(
                  Firestore.instance
                      .document(docsnap[0].reference.path),
                  {'qty': docsnap[0].data['qty'] + event.qty});
            }
          }
        });
      }).catchError((err){
        print(err);
      });
    }
    if (event is DeleteItem) {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.delete(Firestore.instance
            .collection('shoppingcart')
            .document(event.delItem.docID));
      });
    }
  }
}
