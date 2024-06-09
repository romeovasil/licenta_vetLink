import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vetlink/screens/shopping_cart_screen.dart';
import '../model/subscription.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';

class SubscriptionsScreen extends StatefulWidget {
  final String clinicUuid;
  const SubscriptionsScreen({Key? key, required this.clinicUuid}) : super(key: key);

  @override
  _SubscriptionsScreenState createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  late UserProvider userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProvider = Provider.of<UserProvider>(context);
  }

  Future<List<Subscription>> fetchSubscriptions() async {
    var url = Uri.parse('http://localhost:8080/api/v1/mobile/subscriptions/${widget.clinicUuid}');
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((jsonItem) => Subscription.fromMap(jsonItem)).toList();
    } else {
      throw Exception('Failed to load subscriptions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
        title: const Text("Abonamente disponibile"),
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
        child: FutureBuilder<List<dynamic>>(
          future: fetchSubscriptions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
                childAspectRatio: 5 / 3,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, int i) {
                Subscription subscription = snapshot.data![i];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 5,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/vetclinic.jpg',
                              fit: BoxFit.cover,
                              width: 250,
                              height: 115,
                            ),
                          ),
                          Container(
                            height: 110,
                            width: 260,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                                      child: Text(
                                        subscription.name,
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
                                      child: Text(
                                        subscription.shortDescription,
                                        style: TextStyle(color: Colors.black26, fontWeight: FontWeight.bold, fontSize: 13),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.calendar_today, color: Colors.black, size: 15),
                                            SizedBox(width: 4),
                                            Text(
                                              'Recurenta: ' + subscription.recurrence,
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.calendar_today, color: Colors.black, size: 15),
                                              SizedBox(width: 4),
                                              Text(
                                                'Pret:   ' + subscription.price + ' RON',
                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
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
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:  Text('Abonamentul include: '),
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: subscription.shopItems.map((shopItem) {
                                  return Text(
                                    '- ${shopItem.name}(${shopItem.price} RON) ',
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 35),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade500,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('Aboneaza-te'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
