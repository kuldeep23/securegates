import 'package:flutter/material.dart';

class RoundedSquareButton extends StatelessWidget {
  final Function onPress;
  final IconData icon;

  const RoundedSquareButton({
    super.key,
    required this.icon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPress();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Half of 100px
        ),
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(100, 100),
      ),
      child: Icon(
        icon,
        size: 50,
      ),
    );
  }
}
