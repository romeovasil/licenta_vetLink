

class ShopItem {
  final String name;
  final String category;
  final String price;
  final String shortDescription;
  final String quantity;
  final int owner;
  final int id;


  const ShopItem({
    required this.name,
    required this.category,
    required this.price,
    required this.shortDescription,
    required this.quantity,
    required this.owner,
    required this.id,
  });

  static ShopItem fromMap(Map<String, dynamic> map) {
    return ShopItem(
      name: map['name'],
      category: map['category'],
      price: map['price'],
      shortDescription: map['shortDescription'],
      quantity: map['quantity'],
      owner: map['owner'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'shortDescription': shortDescription,
      'quantity': quantity,
      'owner': owner,
      'id': id
    };
  }
}
