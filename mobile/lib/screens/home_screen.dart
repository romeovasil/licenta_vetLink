
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vetlink/widgets/clinic_card.dart';
import '../utils/colors.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<dynamic>> fetchCompanies() async {

    var url = Uri.parse('http://localhost:8080/api/v1/mobile');
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    var response = await http.get(url, headers: headers);


    if (response.statusCode == 200) {

      return json.decode(response.body);
    } else {
      throw Exception('Failed to load companies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
        title: const Text("Clinici Veterinare"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          FutureBuilder<List<dynamic>>(
            future: fetchCompanies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => VetClinicCard(
                  snap: snapshot.data![index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}