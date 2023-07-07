import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:flutter_commercial_nodjs/model/product.dart';

class Order extends Equatable {
  final List<Product> products;
  final int totalPrice;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final List<int> quantity;
  final String id;
  const Order({
    required this.products,
    required this.totalPrice,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.quantity,
    required this.id,
  });

  Order copyWith({
    List<Product>? products,
    int? totalPrice,
    String? address,
    String? userId,
    int? orderedAt,
    int? status,
    List<int>? quantity,
    String? id,
  }) {
    return Order(
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      orderedAt: orderedAt ?? this.orderedAt,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'products': products.map((x) => x.toMap()).toList()});
    result.addAll({'totalPrice': totalPrice});
    result.addAll({'address': address});
    result.addAll({'userId': userId});
    result.addAll({'orderedAt': orderedAt});
    result.addAll({'status': status});
    result.addAll({'quantity': quantity});
    result.addAll({'id': id});

    return result;
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
      totalPrice: map['totalPrice']?.toInt() ?? 0,
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      quantity: List<int>.from(map['products']?.map((x) => x['quantity'])),
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(products: $products, totalPrice: $totalPrice, address: $address, userId: $userId, orderedAt: $orderedAt, status: $status, quantity: $quantity, id: $id)';
  }

  @override
  // TODO: implement props
  List<Object> get props {
    return [
      products,
      totalPrice,
      address,
      userId,
      orderedAt,
      status,
      quantity,
      id,
    ];
  }
}
