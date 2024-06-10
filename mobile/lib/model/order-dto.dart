import 'package:vetlink/model/shop-item.dart';

class OrderDTO {
  final String customerId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String county;
  final String city;
  final String address;
  final String number;
  final String? clinicName;
  final DateTime? orderDate;
  final int price;
  final List<ShopItem> itemDTOs;

  OrderDTO({
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.county,
    required this.email,
    required this.city,
    required this.address,
    required this.clinicName,
    required this.orderDate,
    required this.number,
    required this.price,
    required this.itemDTOs,
  });

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'county': county,
      'city': city,
      'clinicName': clinicName,
      'orderDate': orderDate,
      'address': address,
      'number': number,
      'price': price,
      'itemDTOs': itemDTOs.map((item) => item.toMap()).toList(),
    };
  }

  factory OrderDTO.fromMap(Map<String, dynamic> map) {
    return OrderDTO(
      firstName: map['firstName'],
      lastName: map['lastName'],
      customerId: map['customerId'],
      phoneNumber: map['phoneNumber'],
      orderDate: DateTime.parse(map['orderDate']),
      county: map['county'],
      city: map['city'],
      clinicName: map['clinicName'],
      email: map['email'],
      address: map['address'],
      number: map['number'],
      price: map['price'],
      itemDTOs: List<ShopItem>.from(
        map['itemDTOs']?.map((item) => ShopItem.fromMap(item)),
      ),
    );
  }
}
