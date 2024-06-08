

class Pet {
  final String? id;
  final String name;
  final String race;
  final String subRace;
  final String? photoUrl;
  final String type;
  final String age;
  final String allergy;
  final String healthProblems;
  final String ownerUuid;

  const Pet({
    required this.id,
    required this.name,
    required this.race,
    required this.subRace,
    required this.photoUrl,
    required this.type,
    required this.age,
    required this.allergy,
    required this.healthProblems,
    required this.ownerUuid,
  });

  static Pet fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'],
      name: map['name'],
      race: map['race'],
      subRace: map['subRace'],
      photoUrl: map['photoUrl'],
      type: map['type'],
      age: map['age'],
      allergy: map['allergy'],
      healthProblems: map['healthProblems'],
      ownerUuid: map['ownerUuid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'race': race,
      'subRace': subRace,
      'photoUrl': photoUrl,
      'type': type,
      'age': age,
      'allergy': allergy,
      'healthProblems': healthProblems,
      'ownerUuid': ownerUuid,
    };
  }

  Map<String, dynamic> toMapWithoutPhoto() {
    return {
      'name': name,
      'race': race,
      'subRace': subRace,
      'type': type,
      'age': age,
      'allergy': allergy,
      'healthProblems': healthProblems,
      'ownerUuid': ownerUuid,
    };
  }
}
