import 'package:flutter/material.dart';

class DirectoryMenuWidget extends StatelessWidget {
  const DirectoryMenuWidget({
    super.key,
    required this.cardColor,
    required this.featureText,
    required this.image,
  });

  final ImageProvider image;
  final String featureText;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 0.1,
                    blurRadius: 15,
                    offset: const Offset(0, 7))
              ],
            ),
            child: Image(
              image: image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            featureText,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
