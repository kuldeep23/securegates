import 'package:flutter/material.dart';

class VerticallyDivider extends StatelessWidget {
  final double? height, width;
  final Color? color;
  const VerticallyDivider({
    this.width,
    this.height,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 21,
      width: width ?? 1.4,
      color: color ?? Colors.grey[300],
    );
  }
}
