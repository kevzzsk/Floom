

class Item {
  final String name;
  final int itemID;
  final double price;
  final String image;
  final String description;
  final String discount;
  final bool is_official_shop;
  final double itemRating;
  final bool liked;
  final int likedCount;
  final bool show_free_shipping;
  final int shopID;
  final int catID;

  Item({this.description, this.discount, this.is_official_shop, this.itemRating, this.liked, this.likedCount, this.show_free_shipping, this.shopID, this.catID, this.name, this.itemID, this.price, this.image});
  
  factory Item.fromJSON(Map<dynamic,dynamic> parsedJson){
    return Item(
      name: parsedJson['name'],
      itemID: parsedJson['itemid'],
      price: parsedJson['price'],
      image: parsedJson['image'],
      description: parsedJson['description'],
      discount: parsedJson['discount'],
      is_official_shop: parsedJson['is_official_shop'],
      itemRating:  parsedJson['item_rating'],
      liked: parsedJson['liked'],
      likedCount: parsedJson['liked_count'],
      show_free_shipping: parsedJson['show_free_shipping'],
      shopID: parsedJson['shopid'],
      catID: parsedJson['catid']
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'itemid': itemID,
      'price':price,
      'image':image,
      'description': description,
      'discount': discount,
      'is_official_shop': is_official_shop,
      'itemRating': itemRating,
      'liked': liked,
      'likedCount': likedCount,
      'show_free_shipping': show_free_shipping,
      'shopid': shopID,
      'catid': catID
      };
}