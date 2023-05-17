import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.secureIt,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool secureIt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        obscureText: secureIt,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.deepPurple,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
