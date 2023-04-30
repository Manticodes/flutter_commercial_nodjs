// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/global_variable.dart';
import '../../../model/product.dart';

void rateProduct({
  required BuildContext context,
  required Product product,
  required double rating,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('x-auth-token');

  try {
    http.Response response = await http.post(Uri.parse(uriRateProduct),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode({'id': product.id, 'rating': rating}));
    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('امتیاز شما ثبت شد')));
        });
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
}
