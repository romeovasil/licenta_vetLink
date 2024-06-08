import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/colors.dart';
import '../widgets/pet_card.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  late UserProvider userProvider;
  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: const Text("Animalele tale"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("pets")
                .where('ownerUuid', isEqualTo: userProvider.getUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No pets found"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final doc = snapshot.data!.docs[index];
                  final data = snapshot.data!.docs[index].data();
                  return PetCard(
                    id: doc.id,
                    name: data['name'] ?? 'Unnamed Pet',
                    type: data['type'] ?? 'Unknown Type',
                    allergy: data['allergy'],
                    healthProblems: data['healthProblems'] ,
                    imageUrl: data['photoUrl'] ,
                    age: data['age'] ?? 'Unknown Age',
                    race: data['race'] ?? 'Unknown Race',
                    subrace: data['subRace'] ?? 'Unknown Subrace',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}