// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../constants/error_handle.dart';
import '../../constants/global_variable.dart';
import '../../model/product.dart';

class HomeServices {
  Future<List<Product>> getcategoryProduct(
      {required BuildContext context, required String category}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    List<Product> productList = [];
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
              Product product =
                  Product.fromJson(jsonEncode(jsonDecode(response.body)[i]));
              productList.add(product);
            }
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    return productList;
  }

  Future<List<Product>> getDealsProduct({required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    List<Product> productList = [];
    try {
      http.Response response =
          await http.get(Uri.parse(uriDealOfDay), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              Product product =
                  Product.fromJson(jsonEncode(jsonDecode(response.body)[i]));
              productList.add(product);
            }
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    return productList;
  }
}
