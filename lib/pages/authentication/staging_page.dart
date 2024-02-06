import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StagingPage extends StatelessWidget {
  const StagingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/waiting_animation.json"),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Wait... till your account registration is varified",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FadeInUp(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 1500),
                child: Center(
                    child: RichText(
                  text: const TextSpan(
                      text: "Already have an Account ? ",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                ))),
          ),
        ],
      ),
    );
  }
}
