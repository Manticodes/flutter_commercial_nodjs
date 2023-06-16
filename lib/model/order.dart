import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_commercial_nodjs/model/product.dart';

class Order extends Equatable {
  final List<dynamic> products;
  final int totalPrice;
  final String address;
  final String userId;
  final String orderedAt;
  final int status;
  Order({
    required this.products,
    required this.totalPrice,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
  });

  Order copyWith({
    List<dynamic>? products,
    int? totalPrice,
    String? address,
    String? userId,
    String? orderedAt,
    int? status,
  }) {
    return Order(
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      orderedAt: orderedAt ?? this.orderedAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'products': products});
    result.addAll({'totalPrice': totalPrice});
    result.addAll({'address': address});
    result.addAll({'userId': userId});
    result.addAll({'orderedAt': orderedAt});
    result.addAll({'status': status});

    return result;
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      products: List<Map<String, dynamic>>.from(
        map['products']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      totalPrice: map['totalPrice']?.toInt() ?? 0,
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt'] ?? '',
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(products: $products, totalPrice: $totalPrice, address: $address, userId: $userId, orderedAt: $orderedAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        listEquals(other.products, products) &&
        other.totalPrice == totalPrice &&
        other.address == address &&
        other.userId == userId &&
        other.orderedAt == orderedAt &&
        other.status == status;
  }

  @override
  int get hashCode {
    return products.hashCode ^
        totalPrice.hashCode ^
        address.hashCode ^
        userId.hashCode ^
        orderedAt.hashCode ^
        status.hashCode;
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [products, totalPrice, address, userId, orderedAt, status];
}
