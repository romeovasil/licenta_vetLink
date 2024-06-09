import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../model/shop-item.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  late UserProvider userProvider;
  List<ShopItem> shoppingList = [];

  Future<List<ShopItem>> fetchShopItems(int clinicId) async {
    var url = Uri.parse('http://localhost:8080/api/v1/mobile/shop-items/$clinicId');
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((jsonItem) => ShopItem.fromMap(jsonItem)).toList();
    } else {
      throw Exception('Failed to load shopItems');
    }
  }

  Future<List<String>> getShoppingList() async {
    shoppingList = [];
    try {
      DocumentSnapshot<Map<String, dynamic>> shoppingListsDoc =
      await FirebaseFirestore.instance
          .collection('shoppingLists')
          .doc(userProvider.getUser!.uid)
          .get();

      if (shoppingListsDoc.exists) {
        List<ShopItem> shopItems = await fetchShopItems(shoppingListsDoc.data()!['clinicId']);
        List<int> shoppingListIds = List<int>.from(shoppingListsDoc.data()!['shopItems']);
        setState(() {
          for (var shoppingListItem in shoppingListIds) {
            for (var tempShopItem in shopItems) {
              if (shoppingListItem == tempShopItem.id) {
                shoppingList.add(tempShopItem);
              }
            }
          }
        });
      }
    } catch (error) {}

    return [];
  }

  deleteShopItem(String uid, int shopItemId) async {
    print("de stergs" + shopItemId.toString());
    await FirestoreMethods().deleteShopItem(uid, shopItemId);
    await getShoppingList();
  }

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    getShoppingList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProvider = Provider.of<UserProvider>(context);
  }

  Future<void> clearShoppingList() async {
    await FirestoreMethods().clearShoppingList(userProvider.getUser!.uid);
    await getShoppingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Cos cumparaturi"),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: ListView.builder(
                itemCount: shoppingList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(3, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/vetclinic.jpg'),
                            radius: 30.0,
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.5),
                            child: Column(
                              children: [
                                Text(
                                  shoppingList[index].name,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  shoppingList[index].shortDescription,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      color:const Color(0xEFF37171),
                                      borderRadius: BorderRadius.circular(30)
                                  ) ,
                                  child:  Padding(
                                    padding:  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 22),
                                    child: Text(
                                      shoppingList[index].category,
                                      style: const TextStyle(color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.black),
                                  onPressed: () async {
                                    await deleteShopItem(userProvider.getUser!.uid.toString(), shoppingList[index].id);
                                  },
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${shoppingList[index].price} RON',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF5900),
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 106.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              height: 150.0,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(30),
                color: Colors.white60
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36.0, 25.0, 16.0, 4.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.attach_money,
                          color: Colors.yellow,
                          size: 24.0,
                        ),
                        const SizedBox(width: 8.0),
                        const Text(
                          'Total: ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${shoppingList.fold<int>(0, (sum, item) => sum + int.parse(item.price))} RON',
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36.0, 10.0, 1.0, 4.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.shopping_basket,
                          color: Colors.green,
                          size: 24.0,
                        ),
                        const SizedBox(width: 8.0),
                        const Text(
                          'Numa produse: ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${shoppingList.length}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(36.0, 1.0, 16.0, 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: Colors.black,
                          size: 24.0,
                        ),
                        const Divider(
                          color: Colors.blue,
                          thickness: 1.0,
                          height: 30.0,
                        ),
                        Text(
                          ' Pret transport: ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '29.99 RON',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),


            ),
          ),
          Positioned(
            bottom: 46.0,
            left: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: () async {
                await clearShoppingList();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                textStyle: const TextStyle(fontSize: 18.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text("Avanseaza la plata"),
            ),
          ),
        ],
      ),
    );
  }
}
