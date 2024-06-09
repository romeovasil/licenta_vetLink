import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vetlink/model/customer-subscription-dto.dart';

import '../providers/user_provider.dart';
import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProvider userProvider;
  late Future<CustomerSubscriptionDTO?> customerSubscriptionFuture;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final TextEditingController _changeemailController = TextEditingController();
  final TextEditingController _changeusernameController =
  TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _changepasswordController =
  TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<CustomerSubscriptionDTO?> getCurrentSubscription(String customerId) async {
    var url = Uri.parse('http://localhost:8080/api/v1/mobile/customer-subscription/current/$customerId');
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return CustomerSubscriptionDTO.fromMap(jsonResponse);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    customerSubscriptionFuture = getCurrentSubscription(userProvider.getUser!.uid);
  }

  @override
  void dispose() {
    super.dispose();
    _changeemailController.dispose();
    _passwordController.dispose();
    _changeusernameController.dispose();
    _changepasswordController.dispose();
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      print("Password changed successfully!");
    } catch (e) {
      print("Error changing password: $e");
    }
  }

  bool _isLoading = false;
  void changeCredentials() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: currentUser.email.toString(),
        password: _passwordController.text);
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      var user = await FirebaseAuth.instance.currentUser!;
      if (_changepasswordController.text != "") {
        changePassword(_changepasswordController.text);
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          )));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profilul tau"),
        backgroundColor: mobileBackgroundColor,
        actions: [
          TextButton(
            onPressed: () async {
              await AuthMethods().signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            child: const Text("Sign Out"),
            style: TextButton.styleFrom(
              primary: Colors.white,
              textStyle: TextStyle(fontSize: 18),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          FutureBuilder<CustomerSubscriptionDTO?>(
            future: customerSubscriptionFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text(''));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No subscription data found.'));
              } else {
                var customerSubscriptionDTO = snapshot.data!;
                return Stack(children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white60),
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
                                          customerSubscriptionDTO.subscriptionDTO.name,
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
                                        child: Text(
                                          customerSubscriptionDTO.subscriptionDTO.shortDescription,
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
                                                'Recurenta: ' + customerSubscriptionDTO.subscriptionDTO.recurrence,
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
                                                  'Pret:   ' + customerSubscriptionDTO.subscriptionDTO.price + ' RON',
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
                                    color: Colors.green.shade400,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('Abonamentul include: '),
                                ),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: customerSubscriptionDTO.subscriptionDTO.shopItems.map((shopItem) {
                                    return Text(
                                      '- ${shopItem.name}(${shopItem.price} RON) ',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                     Text(
                                      'Valabil din:    - ${customerSubscriptionDTO.validFrom.toString().substring(0, 10)}',
                                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Pana in data: - ${customerSubscriptionDTO.validUntil.toString().substring(0,10)}',
                                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ]);
              }
            },
          ),
          SizedBox(height: 50),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Parola noua?',
                    style: TextStyle(
                      color: mobileBackgroundColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  //circularWidget
                  Stack(),
                  TextFieldInput(
                    hintText: 'Parola veche',
                    textInputType: TextInputType.text,
                    isPass: true,
                    textEditingController: _passwordController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldInput(
                    hintText: 'Parola noua',
                    textInputType: TextInputType.text,
                    isPass: true,
                    textEditingController: _changepasswordController,

                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  InkWell(
                    onTap: changeCredentials,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          color: Colors.green),
                      child: _isLoading
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: mobileBackgroundColor,
                        ),
                      )
                          : const Text('Salveaza'),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
