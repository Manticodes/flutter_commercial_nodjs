// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/model/order.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/error_handle.dart';
import '../../../constants/global_variable.dart';
import '../../../model/product.dart';

class AcountService {
  Future<List<Order>> getUserOrders(
      {required BuildContext context, required String category}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    List<Order> orderList = [];
    try {
      http.Response response = await http.get(
          Uri.parse('$uriCategoryGetProduct?category=$category'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!,
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              Order order =
                  Order.fromJson(jsonEncode(jsonDecode(response.body)[i]));
              orderList.add(order);
            }
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    return orderList;
  }
}
