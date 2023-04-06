import 'package:flutter/material.dart';

class CostumeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const CostumeTextField(
      {super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 15,
        right: 15,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(), label: Text(label)),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }
}
