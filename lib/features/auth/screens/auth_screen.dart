import 'package:flutter/material.dart';
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
                      CostumeButton(title: 'Sing up', onTap: () {})
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
                  });
                }),
          ),
          auth == Auth.signin
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
                      CostumeButton(title: 'Sing up', onTap: () {})
                    ],
                  ),
                )
              : const SizedBox(),
        ]),
      )),
    );
  }
}
