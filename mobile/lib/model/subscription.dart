

import 'package:vetlink/model/shop-item.dart';

class Subscription {
  final String name;
  final String recurrence;
  final String price;
  final String shortDescription;
  final List<ShopItem> shopItems;


  const Subscription({
    required this.name,
    required this.recurrence,
    required this.price,
    required this.shortDescription,
    required this.shopItems,
  });

  static Subscription fromMap(Map<String, dynamic> map) {
    return Subscription(
      name: map['name'],
      recurrence: map['recurrence'],
      price: map['price'],
      shortDescription: map['shortDescription'],
      shopItems: List<ShopItem>.from(
          map['shopItemDTOs'].map((item) => ShopItem.fromMap(item))
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'recurrence': recurrence,
      'price': price,
      'shortDescription': shortDescription,
      'shopItems': shopItems.map((item) => item.toMap()).toList(),
    };
  }
}
