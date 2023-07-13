import 'package:flutter/material.dart';

class CostumeButton extends StatelessWidget {
  const CostumeButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.color1,
    this.color2,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final Color? color1;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            elevation: 15,
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: color1 ?? Colors.white),
        child: Text(
          title,
          style: TextStyle(
              color: color2 ?? const Color.fromARGB(255, 0, 0, 0),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
