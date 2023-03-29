import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/constants/error_handle.dart';
import 'package:flutter_commercial_nodjs/constants/global_variable.dart';
import 'package:flutter_commercial_nodjs/model/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signUpUser(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      User user = User(
          email: email,
          id: "",
          name: name,
          password: password,
          adress: '',
          type: '',
          token: '');
      http.Response response = await http.post(Uri.parse(uriSignup),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account has been created')));
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
