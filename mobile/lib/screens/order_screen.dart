import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vetlink/utils/StripePaymentHandle.dart';

import '../model/order-dto.dart';
import '../model/shop-item.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import 'package:http/http.dart' as http;

class OrderScreen extends StatefulWidget {
  final List<ShopItem> shoppingList;
  const OrderScreen({Key? key, required this.shoppingList}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late UserProvider userProvider;
  StripePaymentHandle stripePaymentHandle = StripePaymentHandle();
  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String county = '';
  String city = '';
  String address = '';
  String number = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    email = userProvider.getUser!.email;
  }

  Future<void> submitOrder() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      int totalPrice = widget.shoppingList
          .fold(0, (sum, item) => sum + int.parse(item.price)) + 30;

      bool resp = await stripePaymentHandle.makePayment(
          totalPrice.toString(), userProvider.getUser!.uid!, context);
      if (resp) {
        OrderDTO order = OrderDTO(
          customerId: userProvider.getUser!.uid,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          county: county,
          email: email,
          city: city,
          address: address,
          number: number,
          price: totalPrice,
          itemDTOs: widget.shoppingList,
        );

        var url = Uri.parse('http://localhost:8080/api/v1/mobile/order');
        var headers = {
          'Content-Type': 'application/json; charset=utf-8',
        };
        var response = await http.post(url,
            headers: headers, body: json.encode(order.toMap()));

        if (response.statusCode == 200) {
          // Handle successful order submission
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Comanda salvata!')));
          clearShoppingList();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ));
        } else {
          // Handle order submission error
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Eroare salvare comanda, reincercati!')));
        }
      }
    }
  }

  Future<void> clearShoppingList() async {
    await FirestoreMethods().clearShoppingList(userProvider.getUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Detalii comanda"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nume'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rugam introdu numele';
                  }
                  return null;
                },
                onSaved: (value) {
                  lastName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prenume'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rugam introdu prenumele';
                  }
                  return null;
                },
                onSaved: (value) {
                  firstName = value!;
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Telefon'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rugam introdu numarul de telefon';
                  }
                  return null;
                },
                onSaved: (value) {
                  phoneNumber = value!;
                },
              ),
              TextFormField(
                initialValue: userProvider.getUser!.email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rugam introdu emailul';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Judet'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rugam introdu judetul';
                  }
                  return null;
                },
                onSaved: (value) {
                  county = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Oras'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rugam introdu orasul';
                  }
                  return null;
                },
                onSaved: (value) {
                  city = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Strada'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rugam introdu strada';
                  }
                  return null;
                },
                onSaved: (value) {
                  address = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Numar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rugam introdu judetul';
                  }
                  return null;
                },
                onSaved: (value) {
                  number = value!;
                },
              ),
              const SizedBox(height: 50),
              Text(
                'Pret total: ${widget.shoppingList.fold(0, (sum, item) => sum + int.parse(item.price)) + 30.00} RON',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitOrder,
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: const EdgeInsets.all(12.0),
                  textStyle: const TextStyle(fontSize: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text("Mergi la plata"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
