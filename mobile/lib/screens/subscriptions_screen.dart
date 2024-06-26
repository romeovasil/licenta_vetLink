import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vetlink/screens/shopping_cart_screen.dart';
import 'package:vetlink/utils/StripePaymentHandle.dart';
import '../model/customer-subscription-dto.dart';
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
  final StripePaymentHandle stripePaymentHandle = StripePaymentHandle();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProvider = Provider.of<UserProvider>(context);
  }

  Future<void> subscribeToSubscription(Subscription subscription, String userId, BuildContext context) async {
    var url = Uri.parse('http://localhost:8080/api/v1/mobile/customer-subscription');
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };



    var customerSubscriptionDTO = CustomerSubscriptionDTO(
      customerId: userId,
      validFrom: null,
      validUntil: null,
      canceled: false,
      subscriptionDTO: Subscription(
          id: subscription.id,
          name: subscription.name,
          shortDescription: subscription.shortDescription,
          recurrence: subscription.recurrence,
          price: subscription.price,
          shopItems: subscription.shopItems
      ),
    );

    var body = json.encode(customerSubscriptionDTO.toMap());

    var response = await http.post(url, headers: headers, body: body);
    print(response);
    if (response.statusCode == 200) {
      // Handle successful subscription
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('V-ati abonat cu succes la noul abonament!'),
      ));
    } else {
    }
  }


  Future<void> subscribe(Subscription subscription, String customerId) async {
    var url = Uri.parse('http://localhost:8080/api/v1/mobile/customer-subscription/current/$customerId');
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      try {
        json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Aveti deja un abonament valabil!'),
        ));
      } catch(err){
        bool resp = await  stripePaymentHandle.makePayment(subscription.price, userProvider.getUser!.uid!, context);
        if(resp){
          subscribeToSubscription(subscription, userProvider.getUser!.uid!, context);
        }
      }

    }
  }

  Future<List<Subscription>> fetchSubscriptions() async {
    var url = Uri.parse(
        'http://localhost:8080/api/v1/mobile/subscriptions/${widget
            .clinicUuid}');
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((jsonItem) => Subscription.fromMap(jsonItem))
          .toList();
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
                              'assets/subscription.jpg',
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
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
                                        child: Text(
                                          subscription.shortDescription,
                                          style: TextStyle(color: Colors.black26, fontWeight: FontWeight.bold, fontSize: 13),
                                        ),
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
                              SizedBox(height: 15),
                              SizedBox(
                                width: 120,
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade400,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('Abonamentul include: '),
                                ),
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
                              Expanded(
                                child: SizedBox(
                                  height: 10,
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                  onPressed: () => subscribe(subscription,userProvider.getUser!.uid),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green.shade500,
                                    padding: const EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
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
