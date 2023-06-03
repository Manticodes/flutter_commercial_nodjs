// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handle.dart';
import '../../../constants/global_variable.dart';

class CartServices {
  Future<bool> checkItemValidation(
      {required BuildContext context, required String id}) async {
    bool itemExist = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    try {
      http.Response response =
          await http.get(Uri.parse('$uriCheckTheCart?id=$id'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            itemExist = jsonDecode(response.body);
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    print(itemExist);
    return itemExist;
  }
}
