import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/auth/services/auth_server.dart';
import 'package:flutter_commercial_nodjs/features/auth/widgets/costum_button.dart';
import 'package:flutter_commercial_nodjs/features/auth/widgets/costume_textfield.dart';

import '../widgets/pass_textfield.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passController.dispose();
  }

  void clearField() {
    _emailController.clear();
    _nameController.clear();
    _passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          ListTile(
            title: const Text('Create Account'),
            leading: Radio(
                value: Auth.signup,
                groupValue: auth,
                onChanged: (Auth? val) {
                  setState(() {
                    auth = val!;
                    clearField();
                  });
                }),
          ),
          auth == Auth.signup
              ? Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CostumeTextField(
                        controller: _emailController,
                        label: 'Email',
                      ),
                      PassTextField(
                        controller: _passController,
                        label: 'Password',
                      ),
                      CostumeTextField(
                          controller: _nameController, label: 'Name'),
                      CostumeButton(
                          title: 'Sing up',
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              String lEmail =
                                  _emailController.text.toLowerCase();
                              AuthService().signUpUser(
                                  email: lEmail,
                                  password: _passController.text,
                                  name: _nameController.text,
                                  context: context);
                            }
                          })
                    ],
                  ),
                )
              : const SizedBox(),
          ListTile(
            title: const Text('Sign-in'),
            leading: Radio(
                value: Auth.signin,
                groupValue: auth,
                onChanged: (Auth? val) {
                  setState(() {
                    auth = val!;
                    clearField();
                  });
                }),
          ),
          auth == Auth.signin
              ? Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      CostumeTextField(
                        controller: _emailController,
                        label: 'Email',
                      ),
                      PassTextField(
                        controller: _passController,
                        label: 'Password',
                      ),
                      CostumeButton(
                          color1: Color.fromARGB(255, 132, 202, 132),
                          title: 'Sing In',
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              String lEmail =
                                  _emailController.text.toLowerCase();
                              AuthService().signInUser(
                                  email: lEmail,
                                  password: _passController.text,
                                  context: context);
                            }
                          })
                    ],
                  ),
                )
              : const SizedBox(),
        ]),
      )),
    );
  }
}
