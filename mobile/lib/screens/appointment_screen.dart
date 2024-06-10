import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vetlink/model/pet.dart';
import 'package:vetlink/utils/colors.dart';

import '../model/appointment-request-dto.dart';
import '../providers/user_provider.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class AppointmentScreen extends StatefulWidget {
  final String clinicId;


  AppointmentScreen({required this.clinicId});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late String _email;
  late String _phoneNumber;
  late String _details;
  late Pet? _selectedPet;
  late Future<List<Pet>> _fetchPetsFuture;
  late UserProvider userProvider;
  final _formKey = GlobalKey<FormState>();

  Future<List<Pet>> _fetchPets() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("pets")
        .where('ownerUuid', isEqualTo: userProvider.getUser!.uid)
        .get();

    List<Pet> pets = snapshot.docs.map((doc) => Pet.fromMap(doc.data()))
        .toList();
    return pets;
  }

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    _fetchPetsFuture = _fetchPets();
    _selectedPet = null;
    userProvider = Provider.of<UserProvider>(context, listen: false);
    _email = userProvider.getUser!.email;
  }

  Future<void> _submitAppointment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {

        AppointmentRequestDTO appointmentRequestDTO = AppointmentRequestDTO(
          customerId: userProvider.getUser!.uid,
          clinicId: widget.clinicId,
          customerPhoneNumber: _phoneNumber!,
          customerEmail: _email!,
          details: _details!,
          patientDTO: _selectedPet!,
        );
        var headers = {
          'Content-Type': 'application/json; charset=utf-8',
        };
        var requestBody = jsonEncode(appointmentRequestDTO.toMap());
        var response = await http.post(
          Uri.parse('http://localhost:8080/api/v1/mobile/appointment-request'),
          headers: headers,
          body: requestBody,
        );

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Cerere trimisa cu succes!')));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(initialPage: 1),
            webScreenLayout: WebScreenLayout(),
          ),
        ));
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Eroare!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicita o programare'),
        backgroundColor: mobileBackgroundColor,
      ),
      body: FutureBuilder<List<Pet>>(
        future: _fetchPetsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Pet> pets = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      initialValue: _email,
                      onChanged: (value) => _email = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Te rugam introdu in email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Numar de telefon'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Te rugam introdu un numar de telefon';
                        }
                        return null;
                      },
                      onChanged: (value) => _phoneNumber = value,
                    ),
                    DropdownButtonFormField(
                      value: _selectedPet,
                      onChanged: (value) {
                        setState(() {
                          _selectedPet = value;
                        });
                      },
                      items: pets.map((pet) {
                        return DropdownMenuItem(
                          value: pet,
                          child: Text(pet.name),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                          labelText: 'Alege animalul'),
                      validator: (value) {
                        if (value == null) {
                          return 'Te rugam selecteaza un animal';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Detalii'),
                      minLines: 3,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) => _details = value,
                    ),
                    const SizedBox(height: 100),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitAppointment,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Trimite cererea',
                              style: TextStyle(fontSize: 18)),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              mobileBackgroundColor),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity, 50)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
