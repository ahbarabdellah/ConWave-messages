import 'package:flutter/material.dart';

class CTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;

  const CTextFeild({
    required this.controller,
    required this.obscureText,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          fillColor: const Color.fromARGB(255, 165, 198, 255),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black)),
    );
  }
}
