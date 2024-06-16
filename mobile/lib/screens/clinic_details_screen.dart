import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vetlink/screens/appointment_screen.dart';
import 'package:vetlink/screens/shop_items_screen.dart';
import 'package:vetlink/screens/subscriptions_screen.dart';

import '../utils/colors.dart';

class ClinicDetailsScreen extends StatefulWidget {
  final dynamic snap;

  const ClinicDetailsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  _ClinicDetailsScreenState createState() => _ClinicDetailsScreenState();
}

class _ClinicDetailsScreenState extends State<ClinicDetailsScreen> {
  Color _iconColor = const Color.fromARGB(255, 244, 155, 54);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  String getImagePath(String name) {
    int remainder = name.length % 3;
    switch (remainder) {
      case 0:
        return 'assets/vetclinic.jpg';
      case 1:
        return 'assets/vetclinic1.jpg';
      case 2:
        return 'assets/vetclinic2.jpg';
      default:
        return 'assets/vetclinic.jpg';
    }
  }


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Text(
          widget.snap["name"],
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
        height: screenHeight,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 20.0),
                            const SizedBox(width: 4.0),
                            Text(
                               widget.snap['phoneNumber'],
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16.0),
                        Row(
                          children: [
                            const Icon(Icons.house, size: 20.0),
                            const SizedBox(width: 4.0),
                            Text(
                              widget.snap['street']  + ', ' + widget.snap['city'] + ', ' + widget.snap['county'],
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      getImagePath(widget.snap["name"]),
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 8),
                  const Text(
                    'Descriere:',
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.snap['shortDescription']}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SubscriptionsScreen(clinicUuid: widget.snap['id'].toString()),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        ),
                        child: Text("Abonamente"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShopItemsScreen(clinicUuid: widget.snap['id'].toString()),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        ),
                        child: Text("Cumparaturi"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AppointmentScreen(clinicId: widget.snap['id'].toString()),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        ),
                        child: Text("Fa o programare"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}