import 'package:flutter/material.dart';

class CostumeButton extends StatelessWidget {
  const CostumeButton({super.key, required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            elevation: 15, minimumSize: const Size(double.infinity, 50)),
        child: Text(title),
      ),
    );
  }
}
