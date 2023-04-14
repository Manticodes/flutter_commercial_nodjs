import 'package:flutter/material.dart';

class PassTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const PassTextField(
      {super.key, required this.controller, required this.label});

  @override
  State<PassTextField> createState() => _PassTextFieldState();
}

class _PassTextFieldState extends State<PassTextField> {
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        controller: widget.controller,
        obscureText: hide == true ? true : false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text(widget.label),
          suffixIcon: hide == true
              ? InkWell(
                  child: Icon(Icons.remove_red_eye),
                  onTap: () {
                    setState(() {
                      hide = false;
                    });
                  },
                )
              : InkWell(
                  child: Icon(Icons.password),
                  onTap: () {
                    setState(() {
                      hide = true;
                    });
                  },
                ),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please enter your Password';
          }
          return null;
        },
      ),
    );
  }
}
