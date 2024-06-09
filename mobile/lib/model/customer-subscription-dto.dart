import 'package:flutter/foundation.dart';
import 'package:vetlink/model/subscription.dart';

class CustomerSubscriptionDTO {
  final int? id;
  final String customerId;
  final DateTime? validFrom;
  final DateTime? validUntil;
  final bool? canceled;
  final Subscription subscriptionDTO;

  CustomerSubscriptionDTO({
    this.id,
    required this.customerId,
    required this.validFrom,
    required this.validUntil,
    required this.canceled,
    required this.subscriptionDTO,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'validFrom': validFrom?.toIso8601String(),
      'validUntil': validUntil?.toIso8601String(),
      'canceled': canceled,
      'subscriptionDTO': subscriptionDTO.toMap(),
    };
  }

  factory CustomerSubscriptionDTO.fromMap(Map<String, dynamic> map) {
    return CustomerSubscriptionDTO(
      id: map['id'],
      customerId: map['customerId'],
      validFrom: DateTime.parse(map['validFrom']),
      validUntil: DateTime.parse(map['validUntil']),
      canceled: map['canceled'],
      subscriptionDTO: Subscription.fromMap(map['subscriptionDTO']),
    );
  }
}


