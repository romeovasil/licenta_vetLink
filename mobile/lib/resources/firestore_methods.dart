import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vetlink/resources/storage_methods.dart';

import '../model/pet.dart';
import '../utils/utils.dart';

class FirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;




  Future<String> addPet(String name,
      String race,
      String subRace,
      Uint8List file,
      String type,
      String age,
      String allergy,
      String healthProblems,
      String ownerUuid) async {
    String res = "error";
    try {
      String photoUrl =
      await StorageMethods().uploadImageToStorage("pets", file, true);
      String petId = const Uuid().v1();
      Pet pet = Pet(
        id: null,
        name: name,
        race: race,
        subRace: subRace,
        photoUrl: photoUrl,
        type: type,
        age: age,
        allergy: allergy,
        healthProblems: healthProblems,
        ownerUuid: ownerUuid,);

      _firebaseFirestore
          .collection("pets")
          .doc(petId)
          .set(pet.toMap());
      res = "succes";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> updatePet(String? petId, String name,
    String race,
    String subRace,
    String type,
    String age,
    String allergy,
    String healthProblems,
    String ownerUuid) async {
    print(petId);
    Pet pet = Pet(
      id: null,
      name: name,
      race: race,
      subRace: subRace,
      photoUrl: null,
      type: type,
      age: age,
      allergy: allergy,
      healthProblems: healthProblems,
      ownerUuid: ownerUuid,);

    _firebaseFirestore
        .collection("pets")
        .doc(petId)
        .update(pet.toMapWithoutPhoto());
  }


  Future<void> addShopItem(String uid, int clinicId, int shopItemId, BuildContext context) async {
    DocumentReference userShoppingList =
    _firebaseFirestore.collection("shoppingLists").doc(uid);
    var snapshot = await userShoppingList.get();
    var currentShopItems =
    snapshot.exists ? List<int>.from(snapshot['shopItems']) : [];
    int? actualClinicId =  snapshot.exists ? snapshot['clinicId'] : null;
    if (actualClinicId != null && actualClinicId != clinicId) {
      showSnackBar("Aveti deja produse in cos de la alta clinica", context);
    }
    else {
      currentShopItems.add(shopItemId);

      await userShoppingList.set(
          {'shopItems': currentShopItems, 'clinicId': clinicId});

      showSnackBar("Adaugat in cos", context);
    }
  }


  Future<void> deleteShopItem(String uid, int shopItemId) async {

    DocumentReference userShoppingList =
    _firebaseFirestore.collection("shoppingLists").doc(uid);

    var snapshot = await userShoppingList.get();
    var currentShopItems =
    snapshot.exists ? List<int>.from(snapshot['shopItems']) : [];
    currentShopItems.remove(shopItemId);
    if (currentShopItems.isEmpty) {
      await userShoppingList.set(
          {'shopItems': currentShopItems, 'clinicId': null});
    }
    else {
      await userShoppingList.update({'shopItems': currentShopItems});
    }
  }


  Future<void> deletePet(String petId) async {
    try {
      await _firebaseFirestore.collection("pets").doc(petId).delete();

    } catch (e) {
    }
  }





  Future<void> clearShoppingList(String uid) async {
    DocumentReference userShoppingList =
    _firebaseFirestore.collection("shoppingLists").doc(uid);

    var snapshot = await userShoppingList.get();
    var currentShopItems =
    snapshot.exists ? List<int>.from(snapshot['shopItems']) : [];

    currentShopItems.clear();

    await userShoppingList.set({'shopItems': currentShopItems, 'clinicId': null});
  }


}