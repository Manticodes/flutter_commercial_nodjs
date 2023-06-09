// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/logic/bloc_user/user_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/error_handle.dart';
import '../../../constants/global_variable.dart';

class AddressServices {
  void addAdress(String address, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      http.Response resp = await http.post(Uri.parse(uriAddAdress),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!,
          },
          body: jsonEncode({'address': address}));

      httpErrorHandle(
          response: resp,
          context: context,
          onSuccess: () {
            context.read<UserBloc>().add(AddAddress(adrress: address));
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
