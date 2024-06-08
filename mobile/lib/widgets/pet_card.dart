import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pet.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../screens/add_pet_screen.dart';

class PetCard extends StatefulWidget {
  final String id;
  final String name;
  final String type;
  final String allergy;
  final String healthProblems;
  final String imageUrl;
  final String age;
  final String race;
  final String subrace;

  const PetCard({
    Key? key,
    required this.id,
    required this.name,
    required this.type,
    required this.allergy,
    required this.healthProblems,
    required this.imageUrl,
    required this.age,
    required this.race,
    required this.subrace,
  }) : super(key: key);

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  late UserProvider userProvider;
  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20.0),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.imageUrl),
          radius: 30.0,
        ),
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Tip: ${widget.type}'),
            Text('Age: ${widget.age}'),
            Text('Race: ${widget.race}'),
            Text('Subrace: ${widget.subrace}'),
            Text('Alergii: ${widget.allergy}'),
            Text('Probleme sanatate: ${widget.healthProblems}'),
          ],
        ),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                Pet pet = Pet.fromMap({
                  'id': widget.id,
                  'name': widget.name,
                  'race': widget.race,
                  'subRace': widget.subrace,
                  'photoUrl': widget.imageUrl,
                  'type': widget.type,
                  'age': widget.age,
                  'allergy': widget.allergy,
                  'healthProblems': widget.healthProblems,
                  'ownerUuid': userProvider.getUser!.uid, // Assuming ownerUuid is required
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPetScreen(pet: pet),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await FirestoreMethods().deletePet(widget.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
