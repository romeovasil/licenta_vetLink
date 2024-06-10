import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../model/customer-subscription-dto.dart';
import '../model/subscription.dart';

class StripePaymentHandle {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(Subscription subscription , String userId, BuildContext context) async {
    try {
      paymentIntent = await createPaymentIntent(subscription.price, 'RON');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(

          paymentIntentClientSecret: paymentIntent!['client_secret'],

          merchantDisplayName: 'VetLink',
        ),
      );

      bool paymentSuccess = await displayPaymentSheet();
      if (paymentSuccess) {
        await subscribe(subscription, userId, context);
      }
    } catch (e) {
      print("exception $e");
    }
  }

  Future<bool> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // Payment is successful
      paymentIntent = null;
      return true;
    } on StripeException catch (e) {
      // Payment failed
      print('Error: $e');
      return false;
    } catch (e) {
      print("Error in displaying");
      print('$e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var secretKey = "sk_test_51PPsyqKuUEiPobRndChRArDxUXwpPZkLXRHkC9oyGMQO4fL10JTJ7WqbSYX4T6zLinC5rQtGOGTSEgG9IeWCbfgm00iQdGWt0z";
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body: ${response.body.toString()}');
      return jsonDecode(response.body.toString());
    } catch (err) {
      print('Error charging user: ${err.toString()}');
      return null;
    }
  }

  Future<void> subscribe(Subscription subscription, String userId, BuildContext context) async {
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
}
