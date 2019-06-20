

class Item {
  final String name;
  final int itemID;
  final double price;
  final String imageurl;
  String docID;

  Item({this.name, this.itemID, this.price, this.imageurl,this.docID});
  
  factory Item.fromJSON(Map<String,dynamic> parsedJson){
    return Item(
      name: parsedJson['name'],
      itemID: parsedJson['id'],
      price: double.parse(parsedJson['price']),
      imageurl: parsedJson['imageurl'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'id': itemID,
      'price':price.toString(),
      'imageurl':imageurl
      };
}