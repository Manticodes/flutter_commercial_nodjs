import 'package:flutter/material.dart';

class CostumeButton extends StatelessWidget {
  const CostumeButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.color,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            elevation: 15,
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: color == null ? Colors.white : color),
        child: Text(
          title,
          style: const TextStyle(
              color: Color.fromARGB(255, 83, 14, 14),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
