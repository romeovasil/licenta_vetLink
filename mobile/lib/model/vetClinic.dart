class VetClinic {
  final int id;
  final String name;
  final String county;
  final String city;
  final String street;
  final String number;
  final String phoneNumber;
  final String shortDescription;
  final String owner;

  const VetClinic({
    required this.id,
    required this.name,
    required this.county,
    required this.city,
    required this.street,
    required this.number,
    required this.phoneNumber,
    required this.shortDescription,
    required this.owner,
  });


  static VetClinic fromMap(Map<String, dynamic> map) {
    return VetClinic(
      id: map['id'],
      name: map['name'],
      county: map['county'],
      city: map['city'],
      street: map['street'],
      number: map['number'],
      phoneNumber: map['phoneNumber'],
      shortDescription: map['shortDescription'],
      owner: map['owner'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'county': county,
      'city': city,
      'street': street,
      'number': number,
      'phoneNumber': phoneNumber,
      'shortDescription': shortDescription,
      'owner': owner,
    };
  }
}
