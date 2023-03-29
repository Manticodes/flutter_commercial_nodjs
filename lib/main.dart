import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/constants/global_variable.dart';
import 'package:flutter_commercial_nodjs/features/auth/screens/auth_screen.dart';
import 'package:flutter_commercial_nodjs/router.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.light(primary: GlobalVariables.secondaryColor)),
    darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(primary: GlobalVariables.secondaryColor)),
    themeMode: ThemeMode.light,
    onGenerateRoute: (settings) => generateRoute(settings),
    home: const AuthScreen(),
  ));
}
