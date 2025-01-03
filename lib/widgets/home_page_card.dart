import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard({
    super.key,
    required this.featureText,
    required this.image,
    required this.cardColor,
    required,
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
            height: 80,
            width: 80,
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
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                return Center(child: child);
              },
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
