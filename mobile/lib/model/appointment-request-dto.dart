import 'package:flutter/foundation.dart';
import 'package:vetlink/model/pet.dart';
import 'package:vetlink/model/subscription.dart';

class AppointmentRequestDTO {
  final int? id;
  final String customerId;
  final String clinicId;
  final String customerPhoneNumber;
  final String customerEmail;
  final String details;
  final Pet patientDTO;

  AppointmentRequestDTO({
    this.id,
    required this.customerId,
    required this.clinicId,
    required this.customerPhoneNumber,
    required this.customerEmail,
    required this.details,
    required this.patientDTO,
  });

  factory AppointmentRequestDTO.fromMap(Map<String, dynamic> map) {
    return AppointmentRequestDTO(
      id: map['id'],
      customerId: map['customerId'],
      clinicId: map['clinicId'],
      customerPhoneNumber: map['customerPhoneNumber'],
      customerEmail: map['customerEmail'],
      details: map['details'],
      patientDTO: Pet.fromMap(map['patientDTO']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'clinicId': clinicId,
      'customerPhoneNumber': customerPhoneNumber,
      'customerEmail': customerEmail,
      'details': details,
      'patientDTO': patientDTO.toMap(),
    };
  }

}


