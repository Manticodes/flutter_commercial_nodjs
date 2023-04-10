import 'package:flutter/material.dart';

class CostumeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;

  const CostumeTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 15,
        right: 15,
      ),
      child: TextFormField(
        maxLines: maxLines,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
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
