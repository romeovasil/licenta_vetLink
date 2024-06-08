import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vetlink/model/shop-item.dart';

import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';



class ShopItemCard extends StatefulWidget {
  final ShopItem snap;

  ShopItemCard({super.key, required this.snap});
  @override
  _ShopItemCardState createState() => _ShopItemCardState();
}

class _ShopItemCardState extends State<ShopItemCard> {
  late UserProvider userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProvider = Provider.of<UserProvider>(context);
  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
            ),
            Container(
              color: const Color.fromARGB(255, 253, 171, 64),
              child: Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.19,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Image.asset(
                      'assets/vetclinic.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.snap.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'YourCustomFont',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.category, color: Colors.white),
                            const SizedBox(width: 8.0),
                            Text(
                              widget.snap.category,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.attach_money, color: Colors.white),
                            const SizedBox(width: 8.0),
                            Text(
                              widget.snap.price  + ' RON',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            await FirestoreMethods().addShopItem(
                              userProvider.getUser!.uid,
                              widget.snap.owner,
                              widget.snap.id,
                              context
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Adauga in cos',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 56),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
