import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vetlink/screens/shopping_cart_screen.dart';
import '../model/shop-item.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';

class ShopItemsScreen extends StatefulWidget {
  final String clinicUuid;
  const ShopItemsScreen({Key? key, required this.clinicUuid}) : super(key: key);


  @override
  _ShopItemsScreenState createState() => _ShopItemsScreenState();
}


class _ShopItemsScreenState extends State<ShopItemsScreen> {
  late UserProvider userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProvider = Provider.of<UserProvider>(context);
  }

  Future<List<ShopItem>> fetchShopItems() async {
    var url = Uri.parse('http://localhost:8080/api/v1/mobile/shop-items/${widget.clinicUuid}');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
        title: const Text("Produse"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ShoppingCartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  FutureBuilder<List<dynamic>>(
        future: fetchShopItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 9/18
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, int i){
              ShopItem item = snapshot.data![i];
              return Container(
                decoration: BoxDecoration(
                    color:Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 5,
                        offset: const Offset(3,3))
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/vetclinic.jpg',
                      ),
                  ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical:10),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color:Colors.red,
                                borderRadius: BorderRadius.circular(30)
                              ) ,
                              child:  Padding(
                                padding:  EdgeInsets.symmetric(vertical: 7.0, horizontal: 12),
                                child: Text(
                                  item.category,
                                  style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          item.shortDescription,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black38,
                            fontSize: 12,
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${item.price}RON',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blueAccent,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 25),
                             IconButton(
                              onPressed: () async {

                                await FirestoreMethods().addShopItem(
                                  userProvider.getUser!.uid,
                                  item.owner,
                                  item.id,
                                  context,
                                );
                              },
                              icon: Icon(CupertinoIcons.add),
                              color: Colors.red,)
                          ],
                        ),

                      ),

                    ],
                ),
              );
            }
    );}

      ),
    ));
  }
}