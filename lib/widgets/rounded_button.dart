import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onPress;
  final Widget buttonChild;

  const RoundedButton(
      {super.key, required this.onPress, required this.buttonChild});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPress();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30), // Adjust the radius as needed
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: buttonChild,
    );
  }
}
