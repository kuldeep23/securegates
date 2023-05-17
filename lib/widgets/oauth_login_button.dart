import 'package:flutter/material.dart';

class OAuthLoginButton extends StatelessWidget {
  const OAuthLoginButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final Widget icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.deepPurple,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: icon),
      ),
    );
  }
}
