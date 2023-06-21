import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard({
    super.key,
    required this.featureText,
    required this.image,
    required,
  });

  final ImageProvider image;
  final String featureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade600,
              spreadRadius: 0.1,
              blurRadius: 15,
              offset: const Offset(0, 7))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: image,
            fit: BoxFit.fill,
            height: 60,
            width: 60,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            featureText,
            style: GoogleFonts.montserrat(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
