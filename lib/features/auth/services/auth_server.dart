// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/constants/error_handle.dart';
import 'package:flutter_commercial_nodjs/constants/global_variable.dart';
import 'package:flutter_commercial_nodjs/logic/bloc_user/user_bloc.dart';
import 'package:flutter_commercial_nodjs/main.dart';
import 'package:flutter_commercial_nodjs/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
          token: '',
          cart: []);
      http.Response response = await http.post(Uri.parse(uriSignup),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account has been created')));
            signInUser(email: email, password: password, context: context);
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void signInUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      http.Response response = await http.post(Uri.parse(uriSignIn),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.setString('x-auth-token', jsonDecode(response.body)['token']);
            context.read<UserBloc>().add(SetUser(user: response.body));

            Navigator.pushNamedAndRemoveUntil(
              context,
              MyApp.routename,
              (route) => false,
            );
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<User> getUserData({required BuildContext context}) async {
    late User user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    if (token == null) {
      prefs.setString('x-auth-token', '');
    }
    //check the token is valid or not
    var tokenResponse = await http.post(Uri.parse(uriTokenValid),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        });
    var response = jsonDecode(tokenResponse.body);
    if (response == true) {
      //get data of user
      http.Response userDataRes = await http.get(Uri.parse(urigetUser),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          });

      user = User.fromJson(userDataRes.body);
      context.read<UserBloc>().add(SetUser(user: userDataRes.body));
    } else {
      user = User(
          adress: '',
          email: '',
          id: '',
          name: '',
          password: '',
          token: '',
          type: '',
          cart: []);
    }

    debugPrint('token is : ${user.token}');
    return user;
  }
}
