// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/global_variable.dart';
import '../../../logic/bloc_user/user_bloc.dart';

class AddressServices {
  Future<void> addAddress({
    required String address,
    required BuildContext context,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('x-auth-token');

      final http.Response resp = await http.post(
        Uri.parse(uriAddAdress),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode({'address': address}),
      );

      httpErrorHandle(
        response: resp,
        context: context,
        onSuccess: () {
          context.read<UserBloc>().add(AddAddress(adrress: address));
          print('success add address');
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void placeOrder(
      {required String address,
      required int totalPrice,
      required List<dynamic> cart,
      required BuildContext context}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('x-auth-token');

      final http.Response resp = await http.post(
        Uri.parse(uriAddAdress),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode(
            {'address': address, 'totalPrice': totalPrice, 'cart': cart}),
      );

      httpErrorHandle(
        response: resp,
        context: context,
        onSuccess: () {
          context.read<UserBloc>().add(LoadUser());
          print('order successfully placed');
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
