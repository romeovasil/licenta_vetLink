import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vetlink/screens/clinic_details_screen.dart';

class VetClinicCard extends StatelessWidget {
  final snap;
  const VetClinicCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClinicDetailsScreen(
              snap: snap,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15.0),
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

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                color: Colors.orange.shade300,
              ),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Image.asset(
                      'assets/vetclinic.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snap['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'YourCustomFont',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.phone, color: Colors.white),
                              const SizedBox(width: 8.0),
                              Flexible(
                                child: Text(
                                  snap['phoneNumber'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
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
                              const Icon(Icons.house, color: Colors.white),
                              const SizedBox(width: 8.0),
                              Flexible(
                                child: Text(
                                  snap['street']  + ', ' + snap['city'] + ', ' + snap['county'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
