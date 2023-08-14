import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedInputFieldSecond extends StatelessWidget {
  final String hintText;
  final bool isMobile;
  final IconData? leadingIcon;
  final TextEditingController fieldController;

  const RoundedInputFieldSecond({
    super.key,
    required this.hintText,
    required this.isMobile,
    this.leadingIcon,
    required this.fieldController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: fieldController,
        keyboardType: isMobile ? TextInputType.phone : TextInputType.text,
        inputFormatters: isMobile
            ? <TextInputFormatter>[
                // for below version 2 use this
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                FilteringTextInputFormatter.digitsOnly
              ]
            : [],
        decoration: InputDecoration(
            labelText: hintText,
            labelStyle: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
            prefixIcon: Icon(
              leadingIcon,
              color: Colors.black,
              size: 18,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                borderRadius: BorderRadius.circular(10)),
            floatingLabelStyle:
                const TextStyle(color: Color(0xffFF6663), fontSize: 18),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xffFF6663), width: 1.5),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
